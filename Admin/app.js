Object.values = Object.values || (obj => Object.keys(obj).map(key => obj[key]));
var express = require('express');
var mysql = require('mysql');
var bodyParser = require('body-parser');
var generator = require('generate-password');

var app = express();

app.set('view engine', 'ejs');
app.use('/styles', express.static('styles'));
app.use(bodyParser.urlencoded({ extended: false }));

app.listen(3000, function(){
	console.log("listening to port 3000");
});

var connection = mysql.createConnection({
	host: '127.0.0.1',
	user: 'root',
	password: '',
	database: 'handyzebdb'
});

connection.connect(function(err){
	if (err) { console.error(err); return }

	console.log('Connection to database successful!');
});

app.get('/', function(req, res){
	res.render('index');
});

app.get('/main', function(req, res){
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

		connection.query("SELECT * FROM service_provider JOIN user ON idNum=spId ORDER BY rating DESC LIMIT 5;", function(err, rows2){
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

					res.render('main', {customerUsers: customerUsers, topSp: topSp, topCustomers: topCustomers, topServices: topServices});	
				});
			});
		});
	});
});

app.get('/login', function(req, res){
	res.render('login');
});

app.get('/logout', function(req, res){
	res.render('index');
});

app.get('/error', function(req, res){
	res.render('error');
});

app.post('/login', function(req, res){
	var userName = req.body.userName;
	var password = req.body.password;

	connection.query("SELECT userName, userType, password FROM user WHERE status = 1", function(err, rows){
		if (err) { console.error(err); return }

		var valid = false;
		rows.forEach(function(item){
			if(item.userName == userName && item.password == password){
				var userType = item.userType;
				valid = true;

				if(userType == "Customer"){
					res.redirect('/main');
				}else if(userType == "Service Provider"){
					res.redirect('/main');
				}else{
					res.redirect('/main');
				}
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
	res.render('spregister');
});

app.get('/serviceregister', function(req, res){
	res.render('serviceregister');
});

app.post('/register', function(req, res){
	var userColumns = ['userName', 'password', 'userType', 'status']
	var userValues = [req.body.userName, req.body.password, req.body.userType, 0];
	connection.query("INSERT INTO user (??) VALUES (?)", [userColumns, userValues], function(err, results){
		if (err) { console.error(err); return }

		var customerColumns = ['custId', 'address', 'contactNumber', 'email', 'firstName', 'lastName'];
		var customerValues = [results.insertId, req.body.address, req.body.contactNumber, req.body.email, req.body.firstName, req.body.lastName];
		
		connection.query("INSERT INTO customer (??) VALUES (?)", [customerColumns, customerValues], function(err, results){
			if (err) { console.error(err); return }	

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
	var userColumns = ['userName', 'password', 'userType', 'status'];
	var userValues = [req.body.userName, randomPassword, req.body.userType, 1];
	connection.query("INSERT INTO user (??) VALUES (?)", [userColumns, userValues], function(err, results){
		if (err) { console.error(err); return }

		var spColumns = ['spId', 'rating', 'contactNumber', 'email', 'firstName', 'lastName', 'shift_start', 'shift_end', 'working_days'];
		var spValues = [results.insertId, req.body.rating, req.body.contactNumber, req.body.email, req.body.firstName, req.body.lastName, '00:00:00', '00:00:00', ''];
		
		connection.query("INSERT INTO service_provider (??) VALUES (?)", [spColumns, spValues], function(err, results){
			if (err) { console.error(err); return }	

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
});

app.get('/customers', function(req, res){
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
});

app.get('/service-providers', function(req, res){
	var serviceProviders = [];
	connection.query("SELECT * FROM service_provider JOIN user ON idNum=spId", function(err, rows){
		if (err){ console.log("Error in query"); return; }


		rows.forEach(function(item){
			var availability;
			if (item.availability == 1){
				availability = "available";
			}else{
				availability = "unavailable";
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
				rating: item.rating,
				availability: availability
			});
		});

		res.render('service-providers', {serviceProviders: serviceProviders});
	});
});

app.get('/services', function(req, res){
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
});

/*
app.post('/add-service', function(req, res){
	var service = req.body.service;
	console.log(typeof(service));

	connection.query(`INSERT INTO service (serviceType) VALUES('Assembly')`, function(err, result){
		if (err) { console.error(err); return };
		console.log(result);

		res.render(services, {services: services});
	});

});

*/

app.get('/transactions', function(req, res){
	var transactions = [];
	connection.query("SELECT transactionId, CONCAT(sp.firstName, ' ', sp.lastName) 'spName', CONCAT(c.firstName, ' ', c.lastName) 'customerName', serviceType, specification FROM transaction JOIN customer c ON c.custId = transaction.customerId JOIN service_provider sp USING(spId) JOIN service USING(serviceId)", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			//console.log(item);
			transactions.push({
				transactionId: item.transactionId,
				customerName: item.customerName,
				spName: item.spName,
				serviceType: item.serviceType,
				specification: item.specification,
				status: item.status,
				dateStarted: item.date_started,
				dateFinished: item.date_finished
			});
		});
		res.render('transactions', {transactions: transactions});
	});
});


app.post('/accept', function(req, res){
	connection.query("UPDATE user SET status = '1' WHERE userName = '" + req.body.userName +"'", function(err, rows){
		if (err){ console.error(err); return}

		res.redirect('/main');
	});
});

app.post('/reject', function(req, res){
	//DELETE FROM table_name [WHERE Clause]
});