var express = require('express');
var app = express();

app.get('/', function(request, response){
	var mysql = require('mysql');
	var customer = [];
	var sp = [];
	var service = [];

	var connection = mysql.createConnection({
	  host: '127.0.0.1',
	  port: '3307',
	  user: 'root',
	  password: 'RVKolodzik',
	  database: 'handyzeb'
	});

	connection.connect();

	var html = "<html><head><title>index.html</title><body>";
	connection.query('SELECT firstName, lastName, userName, contactNumber, address FROM customer', function(err, rows, fields) {
	  if (!err){
	 	html += '<div class="customer"><h1>Customers</h1>';
	 	html += '<table><tr><th>firstName</th><th>lastName</th><th>userName</th><th>contactNumber</th><th>address</th></tr>';
	  	for(var i = 0; i < rows.length; i++){
	    	html += '<tr><td>' + rows[i].lastName + "</td>"; 
	    	html += "<td>" + rows[i].firstName + "</td>";
	    	html += "<td>" + rows[i].userName + "</td>";
	    	html += "<td>" + rows[i].contactNumber + "</td>";
	    	html += "<td>" + rows[i].address;+ "</td></tr>";
	  		//html += `<p id=customer${i}>` + customer[i] + '</p>';
	  	}

	  	html += '</table><a href=#>Edit</a><a href=#>Delete</a></div>'; 
	  }else{
	    console.log('Error while performing Query.');
	  }
	});

	connection.query('SELECT firstName, lastName, userName, contactNumber, availability FROM service_provider', function(err, rows, fields) {
	  if (!err){

	  	html += '<div class="sp"><h1>Service Providers</h1>';
	  	html += '<table><tr><th>firstName</th><th>lastName</th><th>userName</th><th>contactNumber</th><th>availability</th></tr>';
	  	var availability = "";
	  	for(var i = 0; i < rows.length; i++){
	 		if(rows[i].availability == 1){
	 			availability = "availabe";
	 		}else{
	 			availability = "unavailabe";
	 		}

	    	html += '<tr><td>' + rows[i].lastName + "</td>";
	    	html += '<td>' + rows[i].firstName + "</td>";
	    	html += '<td>' + rows[i].userName + "</td>";
	    	html += '<td>' + rows[i].contactNumber + "</td>";
	    	html += '<td>' + availability; + "</td></tr>";
	  		//html += `<p id=sp${i}>` + sp[i] + '</p>';
	  	}

	  	html += '</table><a href=#>Edit</a><a href=#>Delete</a></div>';
	  }else{
	    console.log('Error while performing Query.');
	  }
	});

	connection.query('SELECT serviceType FROM service', function(err, rows, fields) {
	  if (!err){
	  	html += '<div class="services"><h1>Services</h1>';
	  	html += '<table><tr><th>Service</th></tr>';
	  	for(var i = 0; i < rows.length; i++){
	    	service[i] = rows[i].serviceType + "";
	  		html += `<tr><td>` + service[i] + '</td></tr>';
	  	}

	  	html += '</table><a href=#>Edit</a><a href=#>Delete</a></div></body></html>'; 
	  }else{
	    console.log('Error while performing Query.');
	  }
	});

	connection.query('SELECT * FROM transaction', function(err, rows, fields) {
	  if (!err){
	  	html += '<div class="services"><h1>Transactions</h1>';
	  	html += '<table><tr><th>transactionNumber</th><th>customerNumber</th><th>spNumber</th><th>serviceNumber</th><th>specification</th><th>status</th><th>date_started</th><th>date_finished</th></tr>';
	  	for(var i = 0; i < rows.length; i++){
	  		html += '<tr><td>' + rows[i].transactionNumber + "</td>";
	    	html += '<td>' + rows[i].customerNumber + "</td>";
	    	html += '<td>' + rows[i].spNumber + "</td>";
	    	html += '<td>' + rows[i].serviceNumber + "</td>";
	    	html += '<td>' + rows[i].specification + "</td>";
	    	html += '<td>' + rows[i].status + "</td>";
	    	html += '<td>' + rows[i].date_started + "</td>";
	    	html += '<td>' + rows[i].date_finished + "</td></tr>";
	    	//service[i] = rows[i].serviceTy + "";
	  	}

	  	html += '</table><a href=#>Edit</a><a href=#>Delete</a></div></body></html>'; 
	  	response.end(html);
		connection.end();
	  }else{
	    console.log('Error while performing Query.');
	  }
	});
});

app.listen(1235, function(){
	console.log("Listening to port 1235");
});












// function displayCustomers(){
// 	var mysql = require('mysql');
// 	var customer = [];

// 	var connection = mysql.createConnection({
// 	  host: '127.0.0.1',
// 	  port: '3307',
// 	  user: 'root',
// 	  password: 'RVKolodzik',
// 	  database: 'handyzeb'
// 	});

// 	connection.connect();

// 	connection.query('SELECT firstName, lastName, userName, contactNumber, address FROM customer', function(err, rows, fields) {
// 	  if (!err){
// 	  	for(var i = 0; i < rows.length; i++){
// 	    	customer[i] = rows[i].lastName + ", " + rows[i].firstName + ", " + rows[i].userName + ", " + rows[i].contactNumber + ", " + rows[i].address;
// 	  	}

// 	  	return customer;
// 	  	connection.end();
// 	  }else{
// 	    console.log('Error while performing Query.');
// 	  	connection.end();
// 	  }
// 	});
// }