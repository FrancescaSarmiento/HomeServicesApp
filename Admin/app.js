'use strict';

Object.values = Object.values || (obj => Object.keys(obj).map(key => obj[key]));
var express = require('express');
var mysql = require('mysql');
var bodyParser = require('body-parser');
var generator = require('generate-password');
var session = require('express-session');
var nodemailer = require('nodemailer');

var app = express();

app.set('view engine', 'ejs');
app.use('/styles', express.static('styles'));
app.use(bodyParser.urlencoded({ extended: false }));
app.use(session({
	secret: 'lmao',
	resave: false,
	saveUninitialized: true,
}));

app.listen(3000, function(){
	console.log("listening to port 3000");
});

var connection = mysql.createConnection({
	host: 'localhost',
	port: 3306,
	user: 'handyzeb',
	password: 'webtek2017',
	database: 'handyzebdb'
});

connection.connect(function(err){
	if (err) { console.error(err); return }

	console.log('Connection to database successful!');
});

var transport = nodemailer.createTransport({
	service: 'gmail',
	auth: {
		user: 'handyzeb@gmail.com',
		pass: 'handyzeb2017'
	}
});

app.get('/', function(req, res){
	res.sendFile(__dirname + '/index.html');
});

app.get('/main', function(req, res){
	if(req.session.username){
		connection.query("SELECT * FROM user JOIN customer ON custId=idNum WHERE status='0'  ", function(err, rows1){
			if (err){ console.log(err);	return }

			var customerUsers = [];
			rows1.forEach(function(item){
				//console.log(item);
				customerUsers.push({
					idNum: item.idNum,
					userName: item.userName,
					password: item.password,
					userType: item.userType,
					status: item.status,
					custId: item.custId,
					firstName: item.firstName,
					lastName: item.lastName,
					address: item.address,
					email: item.email,
					contactNumber: item.contactNumber
				});
			});

			connection.query("SELECT feedback.spId, userName, firstName, lastName, AVG(rating) 'rating' FROM service_provider JOIN USER ON idNum = spId JOIN feedback ON service_provider.spId = feedback.spId GROUP BY 1,3,4 ORDER BY 5 DESC LIMIT 5;", function(err, rows2){
				if (err) { console.error(err); return }

				var topSp = [];
				rows2.forEach(function(item){
					topSp.push({
						userName: item.userName,
						spName: `${item.firstName} ${item.lastName}`,
						rating: item.rating
					});
				});

				connection.query("SELECT COUNT(bookingId) 'bookCount', firstName, lastName FROM customer JOIN booking USING (custId) GROUP BY 2,3 LIMIT 5", function(err, rows3){
					if (err) { console.error(err); return }

					var topCustomers = [];
					rows3.forEach(function(item){
						topCustomers.push({
							cName: `${item.firstName} ${item.lastName}`,
							bookCount: item.bookCount
						});
					});

					connection.query("SELECT COUNT(serviceId) 'serviceCount', serviceType FROM transaction NATURAL JOIN service GROUP BY 2 ORDER BY 1 DESC LIMIT 3", function(err, rows4){
						if (err) { console.error(err); return }

						var topServices = [];
						rows4.forEach(function(item){
							topServices.push({
								serviceCount: item.serviceCount,
								serviceType: item.serviceType
							});
						});

						connection.query(`SELECT bookingId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, amount, bookingStatus, dateFinished 
							FROM booking b JOIN customer c ON c.custId = b.custId JOIN service_provider sp USING(spId) JOIN service USING(serviceId) JOIN transaction USING(bookingId) JOIN paymentdetails pd USING(transactionId)  
							WHERE bookingStatus = 'done' ORDER BY dateFinished ASC LIMIT 10;`, function(err, rows4){
							if (err){
								console.log("Error in query" + err);
								return;
							}

							var transactions = [];
							rows4.forEach(function(item){
								//console.log(item);
								transactions.push({
									bookingId: item.bookingId,
									customerName: item.customerName,
									spName: item.spName,
									serviceType: item.serviceType,
									amount: item.amount,
									dateFinished: item.dateFinished
								});
							});

							connection.query("SELECT SUM(amount) 'sum' from paymentdetails", function(err, rows5){
								var sum = [];
								rows5.forEach(function(item){
									sum.push({sum: item.sum});
								});

								res.render('main', {customerUsers: customerUsers, topSp: topSp, topCustomers: topCustomers, topServices: topServices, transactions: transactions, sum: sum});		
							});
							
						});
					});
				});
			});
		});
	}else{
		res.redirect('/login');
	}
});

app.get('/login', function(req, res){
	res.render('login');
});

app.get('/logout', function(req, res){
	req.session.destroy(function(err){
		if (err){ console.error(err); return }
		res.redirect('/');	
	});
});

app.get('/error', function(req, res){
	res.render('error');
});

app.post('/login', function(req, res){
	var userName = req.body.userName;

	connection.query("SELECT userType, userName FROM user WHERE status = 1", function(err, rows){
		if (err) { console.error(err); return }

		var valid = false;
		console.log(rows);
		rows.forEach(function(item){
			if(item.userName == userName){
				valid = true;
				var userType = item.userType;

				if(userType == "Customer"){
					res.redirect('http://customer.handyzeb.org/login.php?userName='+req.body.userName);
				}else if(userType == "Service Provider"){
					res.redirect('http://127.0.0.1:8086/splogin.jsp?userName='+req.body.userName);
				}else{
					res.redirect('/password?userName='+req.body.userName);
				}
			}
		});

		if(!valid){
			res.redirect('/error');
		}
	});
});

var uName = null;
app.get('/password', function(req, res){
	uName = req.query.userName;
	res.render('password');
});

app.post('/password', function(req, res){
	var password = req.body.password; 
	var userName = uName;

	connection.query("SELECT userName, password FROM user WHERE status = 1", function(err, rows){
		if (err) { console.error(err); return }

		var valid = false;
		rows.forEach(function(item){
			if(item.userName == userName && item.password == password){
				var userType = item.userType;
				valid = true;

				req.session.username = userName;
				res.redirect('/main');
			}
		});

		if(!valid){
			res.redirect('/error');
		}
	});
});

app.get('/register', function(req, res){
	res.render('register');
});

app.get('/spregister', function(req, res){
	if(req.session.username){
		res.render('spregister');
	}else{
		res.redirect('/login');
	}
});

app.post('/register', function(req, res){
	var userColumns = ['userName', 'password', 'userType', 'status', 'balance']
	var userValues = [req.body.userName, req.body.password, req.body.userType, 0, 0];
	connection.query("INSERT INTO user (??) VALUES (?)", [userColumns, userValues], function(err, results){
		if (err) { 
			console.error(err);

			var message = {
				text: "Username has been taken"
			}
			res.render('register', message);
			return;
		}

		var customerColumns = ['custId', 'address', 'contactNumber', 'email', 'firstName', 'lastName'];
		var customerValues = [results.insertId, req.body.address, req.body.contactNumber, req.body.email, req.body.firstName, req.body.lastName];
		
		connection.query("INSERT INTO customer (??) VALUES (?)", [customerColumns, customerValues], function(err, results){
			if (err) { 
				console.error(err); 
				return;
			}	

			res.render('register-success', customerValues);
		});
	});
});

app.get('/register-success', function(req, res){
	res.render('register-success');
})

app.post('/spregister', function(req, res){
	var randomPassword = generator.generate({
		length: 10,
		numbers: true
	});
	var userColumns = ['userName', 'password', 'userType', 'status', 'balance'];
	var userValues = [req.body.userName, randomPassword, req.body.userType, 1, 0.0];
	connection.query("INSERT INTO user (??) VALUES (?)", [userColumns, userValues], function(err, results){
		if (err) { 
			console.error(err); 
			
			var message = {
				text: "Username has been taken"
			}

			res.render('spregister', message);
			return;	
		}

		var spColumns = ['spId', 'contactNumber', 'email', 'firstName', 'lastName', 'shift_start', 'shift_end', 'working_days'];
		var spValues = [results.insertId, req.body.contactNumber, req.body.email, req.body.firstName, req.body.lastName, '00:00:00', '00:00:00', ''];
		
		connection.query("INSERT INTO service_provider (??) VALUES (?)", [spColumns, spValues], function(err, results){
			if (err) { console.error(err); return }	

			var spEmail = req.body.email;

		  	transport.sendMail({
		    	from: 'Handy Zeb!',
		    	to: spEmail,
		   		subject: 'Account',
				text: 'You now have an account for Handy Zeb!' + 
					' Your User Name is: ' + req.body.userName +
					' Your Password is: ' + randomPassword +
					' Try logging in to our site now! ' +
					'www.handyzeb.org'
			});

			res.redirect('/service-providers');
		});
	});
});

app.get('/spregister-success', function(req, res){
	res.render('register-success');
})

app.post('/serviceregister', function(req, res){
	var serviceColumns = ['serviceType'];
	var serviceValues = [req.body.serviceType];

	connection.query("INSERT INTO service (??) VALUES (?)", [serviceColumns, serviceValues], function(err, results){
		if (err) { console.error(err); return }

	});

	res.redirect('/services');
});

app.get('/users', function(req, res){
	if(req.session.username){
		var users = [];
		connection.query("SELECT * FROM user", function(err, rows){
			if (err){ console.log("Error in query"); return; }

			rows.forEach(function(item){
				//console.log(item);
				users.push({
					idNum: item.idNum,
					userName: item.userName,
					password: item.password,
					userType: item.userType,
					status: item.status
				});
			});
			res.render('users', {users: users});
		});
	}else{
		res.redirect('/login');
	}
});

app.get('/customers', function(req, res){
	if(req.session.username){
		var customers = [];
		connection.query("SELECT * FROM customer JOIN user ON custId = idNum WHERE status = '1'", function(err, rows){
			if (err){ console.log("Error in query"); return; }


			rows.forEach(function(item){
				//console.log(item);
				customers.push({
					custId: item.custId,
					firstName: item.firstName,
					userName: item.userName,
					lastName: item.lastName,
					address: item.address,
					email: item.email,
					contactNumber: item.contactNumber
				});
			});

			res.render('customers', {customers: customers});
		});
	}else{
		res.redirect('/login');
	}
	
});

app.get('/service-providers', function(req, res){
	if(req.session.username){
		var serviceProviders = [];
		connection.query("SELECT service_provider.spId, userName, firstName, lastName, email, contactNumber, shift_start, shift_end, status, working_days, AVG(rating) 'rating', SUM(amount) 'earnings' FROM service_provider LEFT JOIN USER ON idNum = spId LEFt JOIN booking USING(spId) LEFT JOIN TRANSACTION USING (bookingId) LEFT JOIN paymentdetails USING(transactionId) LEFT JOIN feedback USING(transactionId) GROUP BY 1, 3, 4, 5", function(err, rows){
			if (err){ console.error(err); return; }


			rows.forEach(function(item){
				var earnings = item.earnings;
				var rating = item.rating;
				if(item.earnings == null){
					earnings = 0.00;
				}
				if(item.rating == null){
					rating = 0;
				}

				serviceProviders.push({
					spId: item.spId,
					userName: item.userName,
					firstName: item.firstName,
					lastName: item.lastName,
					email: item.email,
					contactNumber: item.contactNumber,
					shiftStart: item.shift_start,
					shiftEnd: item.shift_end,
					workingDays: item.working_days,
					rating: rating,
					earnings: earnings,
					status: item.status
				});
			});

			res.render('service-providers', {serviceProviders: serviceProviders});
		});
	}else{
		res.redirect('/login');
	}
});

app.get('/services', function(req, res){
	if(req.session.username){
		var services = [];	

		connection.query("SELECT * FROM service", function(err, rows){
			if (err){ console.log("Error in query"); return; }

			rows.forEach(function(item){
				//console.log(item);
				services.push({
					serviceId: item.serviceId,
					service: item.serviceType
				});
			});
			res.render('services', {services: services});
		});
	}else{
		res.redirect('/login');
	}
});

app.get('/transactions', function(req, res){
	if(req.session.username){
		var transactions = [];
		connection.query("SELECT bookingId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, bookingStatus, dateStarted, dateFinished FROM booking b JOIN customer c ON c.custId = b.custId JOIN service_provider sp USING(spId) JOIN service USING(serviceId);", function(err, rows){
			if (err){
				console.log("Error in query" + err);
				return;
			}

			rows.forEach(function(item){
				//console.log(item);
				transactions.push({
					bookingId: item.bookingId,
					customerName: item.customerName,
					spName: item.spName,
					serviceType: item.serviceType,
					bookingStatus: item.bookingStatus,
					dateStarted: item.dateStarted,
					dateFinished: item.dateFinished
				});
			});
			res.render('transactions', {transactions: transactions});
		});
	}else{
		res.redirect('/login');
	}
});


app.post('/accept', function(req, res){
	connection.query("UPDATE user SET status = '1' WHERE userName = '" + req.body.userName +"'", function(err, rows){
		if (err){ console.error(err); return}

		var customer = [];
		connection.query("SELECT email FROM customer JOIN user ON idNum = custId WHERE userName = '" + req.body.userName +"'", function(err, rows){
			if (err){ console.error(err); return}

			var customerEmail = null;
			rows.forEach(function(item){
				customerEmail = item.email;
			});

			//console.log(customerEmail);

		  	transport.sendMail({
		    	from: 'Handy Zeb!',
		    	to: customerEmail,
		   		subject: 'Account',
				text: 'Congrationlations, you can now use your Handy Zeb account! ' +
				'Thank you for registering to our Home Service Application. Please use the link below to try loging in to our site. ' +
				'www.handyzeb.org/login'
			});
		});

		res.redirect('/main');
	});
});

app.post('/reject', function(req, res){
	connection.query("SELECT email FROM customer JOIN user ON idNum = custId WHERE idNum = '" + req.body.idNum +"'", function(err, rows){
		if (err){ console.error(err); return}

		var customerEmail = null;
		rows.forEach(function(item){
			customerEmail = item.email;
		});

		//console.log(customerEmail);

	  	transport.sendMail({
	    	from: 'Handy Zeb!',
	    	to: customerEmail,
	   		subject: 'Account',
			text: 'We are so sorry, but your account has been rejected by the administrator. Please try again some other time.'
		});
	});

	var values = [req.body.idNum];
	connection.query("DELETE FROM customer WHERE custId = ?", [values], function(err, rows){
		if (err){ console.error(err); return }

		connection.query("DELETE FROM user WHERE idNum = ?", [values], function(err, rows1){
			if (err){ console.error(err); return }

			res.redirect('/main');
		});
	});
});

app.post('/suspend', function(req, res){
	//DELETE FROM table_name [WHERE Clause]
	connection.query("UPDATE user SET status = '0' WHERE idNum = '" + req.body.userId +"'", function(err, rows){
		if (err){ console.error(err); return}

		var user = [];
		connection.query("SELECT email FROM service_provider JOIN user ON idNum = spId WHERE idNum = '" + req.body.userId +"'", function(err, rows){
			if (err){ console.error(err); return}

			var spEmail = null;
			rows.forEach(function(item){
				spEmail = item.email;
			});

			//console.log(customerEmail);

		  	transport.sendMail({
		    	from: 'Handy Zeb!',
		    	to: spEmail,
		   		subject: 'Account',
				text: 'We are so sorry, but your account has been suspended by the administrator. Please contact a HandyZeb Admin for clarifications.'
			});
		});

		res.redirect('/service-providers');
	});
});

app.post('/unsuspend', function(req, res){
	//DELETE FROM table_name [WHERE Clause]
	connection.query("UPDATE user SET status = '1' WHERE idNum = '" + req.body.userId +"'", function(err, rows){
		if (err){ console.error(err); return}

		connection.query("SELECT email FROM service_provider JOIN user ON idNum = spId WHERE idNum = '" + req.body.userId +"'", function(err, rows){
			if (err){ console.error(err); return}

			var spEmail = null;
			rows.forEach(function(item){
				spEmail = item.email;
			});

			//console.log(customerEmail);

		  	transport.sendMail({
		    	from: 'Handy Zeb!',
		    	to: spEmail,
		   		subject: 'Account',
				text: 'Your account has been unsuspended.' +
					' You can now again use your account with your previous credentials. ' + 
					'www.handyzeb.org'
			});
		});

		res.redirect('/service-providers');
	});
});

app.post('/search-customer', function(req, res){
	var values = [req.body.searchItem];
	var customers = [];
	connection.query(`SELECT * FROM customer JOIN user ON custId = idNum WHERE status = '1' AND lastName LIKE '%${req.body.searchItem}%' OR firstName LIKE '%${req.body.searchItem}%'`, function(err, rows){
		if (err){ console.error(err); return }

		rows.forEach(function(item){
			//console.log(item);
			customers.push({
				custId: item.custId,
				firstName: item.firstName,
				userName: item.userName,
				lastName: item.lastName,
				address: item.address,
				email: item.email,
				contactNumber: item.contactNumber
			});
		});

		res.render('customers', {customers: customers});
	});
});

app.post('/search-sp', function(req, res){
	var values = [req.body.searchItem];
	var sp = [];
	connection.query(`SELECT booking.spId, userName, firstName, lastName, email, contactNumber, shift_start, shift_end, status, working_days, AVG(rating) 'rating', SUM(amount) 'earnings' FROM service_provider LEFT JOIN USER ON idNum = spId LEFt JOIN booking USING(spId) LEFT JOIN TRANSACTION USING (bookingId) LEFT JOIN paymentdetails USING(transactionId) LEFT JOIN feedback USING(transactionId) WHERE status = '1' AND lastName LIKE '%${req.body.searchItem}%' OR firstName LIKE '%${req.body.searchItem}%' GROUP BY 1, 3, 4, 5`, function(err, rows){
		if (err){ console.error(err); return }

		rows.forEach(function(item){
			var earnings = item.earnings;
			var rating = item.rating;
			if(item.earnings == null){
				earnings = 0.00;
			}
			if(item.rating == null){
				rating = 0;
			}

			sp.push({
				spId: item.spId,
				userName: item.userName,
				firstName: item.firstName,
				lastName: item.lastName,
				email: item.email,
				contactNumber: item.contactNumber,
				shiftStart: item.shift_start,
				shiftEnd: item.shift_end,
				workingDays: item.working_days,
				rating: rating,
				earnings: earnings,
				status: item.status
			});
		});

		res.render('service-providers', {serviceProviders: sp});
	});
});

app.post('/search-sp-on-status', function(req, res){
	var status = [req.body.status];
	var sp = [];

	if(status == 'suspended'){
		status = 0;
	}else{
		status = 1;
	}

	connection.query(`SELECT booking.spId, userName, firstName, lastName, email, contactNumber, shift_start, shift_end, status, working_days, AVG(rating) 'rating', SUM(amount) 'earnings' FROM service_provider LEFT JOIN USER ON idNum = spId LEFt JOIN booking USING(spId) LEFT JOIN TRANSACTION USING (bookingId) LEFT JOIN paymentdetails USING(transactionId) LEFT JOIN feedback USING(transactionId) WHERE status = '${status}' GROUP BY 1, 3, 4, 5`, function(err, rows){
		if (err){ console.error(err); return }

		rows.forEach(function(item){
				var earnings = item.earnings;
				var rating = item.rating;
				if(item.earnings == null){
					earnings = 0.00;
				}
				if(item.rating == null){
					rating = 0;
				}

				sp.push({
					spId: item.spId,
					userName: item.userName,
					firstName: item.firstName,
					lastName: item.lastName,
					email: item.email,
					contactNumber: item.contactNumber,
					shiftStart: item.shift_start,
					shiftEnd: item.shift_end,
					workingDays: item.working_days,
					rating: rating,
					earnings: earnings,
					status: item.status
				});
			});

		res.render('service-providers', {serviceProviders: sp});
	});
});

app.post('/search-transaction-on-date', function(req, res){

	var values = [req.body.searchItem];
	var status = [req.body.status];
	var trans = [];
	connection.query(`SELECT bookingId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, bookingStatus, dateStarted, dateFinished FROM booking b JOIN customer c ON c.custId = b.custId JOIN service_provider sp USING(spId) JOIN service USING(serviceId) 
		WHERE dateFinished BETWEEN '${req.body.from}%' AND '${req.body.to}%'`, function(err, rows){
		
		if (err){ console.error(err); return }

		rows.forEach(function(item){
			//console.log(item);
			trans.push({
				bookingId: item.bookingId,
				customerName: item.customerName,
				spName: item.spName,
				serviceType: item.serviceType,
				bookingStatus: item.bookingStatus,
				dateStarted: item.dateStarted,
				dateFinished: item.dateFinished
			});
		});

		res.render('transactions', {transactions: trans});
	});
});

app.post('/search-transaction-on-name', function(req, res){

	var values = [req.body.searchItem];
	var status = [req.body.status];
	var trans = [];
	connection.query(`SELECT bookingId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, bookingStatus, dateStarted, dateFinished FROM booking b JOIN customer c ON c.custId = b.custId JOIN service_provider sp USING(spId) JOIN service USING(serviceId) WHERE c.lastName LIKE '%${req.body.searchItem}%' OR c.firstName LIKE '%${req.body.searchItem}%' OR sp.lastName LIKE '%${req.body.searchItem}%' OR sp.firstName LIKE '%${req.body.searchItem}%'`, function(err, rows){
		if (err){ console.error(err); return }

		rows.forEach(function(item){
			//console.log(item);
			trans.push({
				bookingId: item.bookingId,
				customerName: item.customerName,
				spName: item.spName,
				serviceType: item.serviceType,
				bookingStatus: item.bookingStatus,
				dateStarted: item.dateStarted,
				dateFinished: item.dateFinished
			});
		});

		res.render('transactions', {transactions: trans});
	});
});

app.post('/search-transaction-on-status', function(req, res){

	var values = [req.body.searchItem];
	var status = [req.body.status];
	var trans = [];
	connection.query(`SELECT bookingId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, bookingStatus, dateStarted, dateFinished FROM booking b JOIN customer c ON c.custId = b.custId JOIN service_provider sp USING(spId) JOIN service USING(serviceId) WHERE bookingStatus = '${req.body.status}'`, function(err, rows){
		if (err){ console.error(err); return }

		rows.forEach(function(item){
			//console.log(item);
			trans.push({
				bookingId: item.bookingId,
				customerName: item.customerName,
				spName: item.spName,
				serviceType: item.serviceType,
				bookingStatus: item.bookingStatus,
				dateStarted: item.dateStarted,
				dateFinished: item.dateFinished
			});
		});

		res.render('transactions', {transactions: trans});
	});
});

app.get('/edit-sp', function(req, res){
	var sp = [];
	var values = [req.query.userName];
	connection.query("SELECT * FROM service_provider JOIN user ON idNum=spId WHERE userName=?", [values], function(err, rows){
		if (err) {console.error(err); return }

		rows.forEach(function(item){
			sp.push({
				idNum: item.idNum,
				userName: req.query.userName,
				firstName: item.firstName,
				lastName: item.lastName,
				email: item.email,
				contactNumber: item.contactNumber,
			});
		});

		res.render('edit-sp', {user: sp});
	});
});

app.post('/edit-sp', function(req,res){
	var columns = Object.keys(req.body);
	var values = Object.values(req.body);
	var where = [req.query.idnum];
	console.log(req.query.idnum);

	
	connection.query("UPDATE service_provider SET ??=? WHERE spId=?", [columns, values, where], function(err, rows){
		if (err){ console.error(err); return }
		console.log(rows);
		var sp = {};
		connection.query("SELECT * FROM service_provider JOIN user ON idNum=spId WHERE spId=?",[where], function(err, rows){
			if (err){ console.error(err); return; }

			rows.forEach(function(item){
				sp.spId = item.spId,
				sp.userName = item.userName,
				sp.password = item.password,
				sp.firstName = item.firstName,
				sp.lastName = item.lastName,
				sp.email = item.email,
				sp.contactNumber = item.contactNumber
			});

			transport.sendMail({
		    	from: 'Handy Zeb!',
		    	to: req.body.email,
		   		subject: 'Account',
				text: `
Hello ${sp.firstName} ${sp.lastName}!

You now have an account for Handy Zeb! 
		Your User Name is:   ${sp.userName}
		Your Password is:  ${sp.password}
Try logging in to our site now! 
		www.handyzeb.org`
			});

			res.redirect('/service-providers');	
		});
	});
});