Object.values = Object.values || (obj => Object.keys(obj).map(key => obj[key]));
var express = require('express');
var mysql = require('mysql');
var bodyParser = require('body-parser');

var app = express();

app.set('view engine', 'ejs');
app.use('/styles', express.static('styles'));
app.use(bodyParser.urlencoded({ extended: false }));

app.listen(3000, function(){
	console.log("listening to port 3000");
});

var connection = mysql.createConnection({
	host: '127.0.0.1',
	port: '3307',
	user: 'root',
	password: 'RVKolodzik',
	database: 'handyzebdb'
});

app.get('/', function(req, res){
	var customerUsers = [];
	connection.query("SELECT * FROM user JOIN customer ON custId=idNum WHERE status='0'", function(err, rows){
		if (err){
			console.log(err);
			return;
		}

		rows.forEach(function(item){
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
		res.render('index', {customerUsers: customerUsers});
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

app.get('/login', function(req, res){
	res.render('login');
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

app.post('/login', function(req, res){
	var userName = req.body.userName;
	var password = req.body.password;

	connection.query("SELECT * FROM user", function(err, rows){
		if (err) { console.error(err); return }

		rows.forEach(function(item){
			if(item.userName == userName && item.password == password){
				var userType = item.userType;

				if(userType == "Customer"){
					app.get('../Customer/home-page', function(req, res){
						res.render('home-page');
					})
				}else if(userType = "Service Provider"){
					app.get('../SP/build/web/WEB-INF/index', function(req, res){
						res.render('index');
					})
				}else{
					app.get('/index', function(req, res){
						res.render('index');
					})
				}
			}else{
				app.get('/login', function(req, res){
					res.render('login');
				})
			}
		});
	});
});

app.post('/spregister', function(req, res){
	var userColumns = ['userName', 'password', 'userType', 'status']
	var userValues = [req.body.userName, req.body.password, req.body.userType, 1];
	connection.query("INSERT INTO user (??) VALUES (?)", [userColumns, userValues], function(err, results){
		if (err) { console.error(err); return }

		var spColumns = ['spId', 'rating', 'contactNumber', 'email', 'firstName', 'lastName'];
		var spValues = [results.insertId, req.body.rating, req.body.contactNumber, req.body.email, req.body.firstName, req.body.lastName];
		
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
		if (err){
			console.log("Error in query");
			return;
		}

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


//TEST METHOD FOR INSTERING ROWS TO DB
app.post('/test-add-user', function(req, res){
	var columns = Object.keys(req.body);
	var values = Object.values(req.body);
	connection.query("INSERT INTO user (??) VALUES (?)", [columns, values], function(err, result){
		if (err) { console.error(err); return }
		res.redirect('back');
	});
});


app.get('/customers', function(req, res){
	var customers = [];
	connection.query("SELECT * FROM customer JOIN user ON idNum = custId WHERE status = '1'", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			//console.log(item);
			customers.push({
				custId: item.custId,
				firstName: item.firstName,
				lastName: item.lastName,
				userName: item.userName,
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
	connection.query("SELECT * FROM service_provider JOIN user ON idNum = spId", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			var availability;
			if (item.availability == 1){
				availability = "available";
			}else{
				availability = "unavailable";
			}
			//console.log(item);
			serviceProviders.push({
				spId: item.spId,
				firstName: item.firstName,
				lastName: item.lastName,
				userName: item.userName,
				email: item.email,
				contactNumber: item.contactNumber,
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
		if (err){
			console.log("Error in query");
			return;
		}

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
	connection.query("SELECT * FROM transaction", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			//console.log(item);
			transactions.push({
				transactionId: item.transactionId,
				customerId: item.customerId,
				spId: item.spId,
				serviceId: item.serviceId,
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

		res.redirect('/');
	});
});

app.post('/reject', function(req, res){

});