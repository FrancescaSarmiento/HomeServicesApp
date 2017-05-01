var express = require('express');
var mysql = require('mysql');

var app = express();
app.set('view engine', 'ejs');
app.use('/styles', express.static('styles'));


var connection = mysql.createConnection({
	host: 'localhost',
	user: 'root',
	password: '',
	database: 'handyzebdb'
});

app.get('/', function(req, res){
	res.render('index');
});

app.get('/customers', function(req, res){
	var customers = [];
	connection.query("SELECT firstName, lastName, userName, contactNumber, address FROM customer", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			//console.log(item);
			customers.push({
				firstName: item.firstName,
				lastName: item.lastName,
				userName: item.userName,
				contactNumber: item.contactNumber,
				address: item.address
			});
		});

		res.render('customers', {customers: customers});
	});
});

app.get('/service-providers', function(req, res){
	var serviceProviders = [];
	connection.query("SELECT firstName, lastName, userName, contactNumber, availability FROM service_provider", function(err, rows){
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
				firstName: item.firstName,
				lastName: item.lastName,
				userName: item.userName,
				contactNumber: item.contactNumber,
				availability: availability
			});
		});

		res.render('service-providers', {serviceProviders: serviceProviders});
	});
});

app.get('/services', function(req, res){
	var services = [];
	connection.query("SELECT serviceType FROM service", function(err, rows){
		if (err){
			console.log("Error in query");
			return;
		}

		rows.forEach(function(item){
			//console.log(item);
			services.push({
				service: item.serviceType
			});
		});
		res.render('services', {services: services});
	});
});

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
				transactionNumber: item.transactionNumber,
				customerNumber: item.customerNumber,
				spNumber: item.spNumber,
				service: item.serviceNumber,
				specification: item.specification,
				status: item.status,
				dateStart: item.date_started,
				dateFinished: item.date_finished
			});
		});
		res.render('transactions', {transactions: transactions});
	});
})

app.listen(3000, function(){
	console.log("listening to port 3000");
});