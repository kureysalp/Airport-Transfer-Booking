const express = require('express');
const app = express();
const httpApp = express();
const http = require('http');
const https = require('https');
const fetch = require('node-fetch');
const bcrypt = require('bcrypt');
const hogan = require('hogan.js');
const fs = require('fs');

const optionSSL = {
    key: fs.readFileSync("./etc/ssl/damataxi.pem"),
    cert: fs.readFileSync("./etc/ssl/damataxi.crt")
};

app.use(express.static('public', {
    extensions: ['html', 'htm'],
}));
app.use(express.json({limit: '1mb'}));
app.use(express.urlencoded({ extended: false }));
app.enable('trust proxy');

//Log system
const SimpleNodeLogger = require('simple-node-logger'),
    opts = {
        logFilePath:'dama-logs.log',
        timestampFormat:'YYYY-MM-DD HH:mm:ss.SSS'
    },
log = SimpleNodeLogger.createSimpleLogger( opts );

var auth = false;

//Get the user's IP address
app.get('/', function (req, res) {
    //var userIP = req.connection.remoteAddress;
    //log.info(userIP + " connected to the site.");
    log.info("Someone entered the site.");
});

//GOOGLE PLACES AUTO COMPLETE
app.get('/placesAC/:input', async (request, response) => {
    const userInput = request.params['input'];    
    const placesAPI = 'https://maps.googleapis.com/maps/api/place/autocomplete/json?';
    const placeConditions = '&region=tr';
    const APIKey = '&key=API_KEY';
    const input = 'input=' + encodeURIComponent(userInput);

    const finalURL = placesAPI + input + placeConditions + APIKey;
    
    const fetch_response = await fetch(finalURL);
    const json = await fetch_response.json();    

    response.json(json);
    console.log(userInput);
});

//Google Distance Matrix API
app.get('/distanceMatrix/:destinations', async (request, response) => {
    const destinations = request.params['destinations'].split(',');
    const distanceMatrixAPI = 'https://maps.googleapis.com/maps/api/distancematrix/json?';    
    const parameters = "units=metric&origins=place_id:" + destinations[0] + "&destinations=place_id:" + destinations[1];
    const APIKey = '&key=API_KEY';

    const finalURL = distanceMatrixAPI + parameters + APIKey;    

    const fetch_response = await fetch(finalURL);
    const json = await fetch_response.json();

    response.json(json);
    log.info("Searched for "+ destinations[0] + " - " + destinations[1]);
    log.info("Searched for "+ destinations[0] + " - " + destinations[1]);
});

app.get('/geocode/:address', async(req, res) => {
    const address = req.params['address'];
    const geocodeAPI = 'https://maps.googleapis.com/maps/api/geocode/json?';
    const parameters = 'address=' + encodeURIComponent(address);
    const APIKey = '&key=API_KEY';
    
    const finalURL = geocodeAPI + parameters + APIKey;    

    const fetch_response = await fetch(finalURL);
    const json = await fetch_response.json();    
    res.json(json);
});

//Calculate price dure to distance
app.get('/calculatePrice/:distanceAndVehicle', async (request, response) => {
    const params = request.params['distanceAndVehicle'].split(',');    
    const distance = params[0];
    const vehicle = params[1];

    var price;    

    if(vehicle == "Economy") {
        if (distance <= 55) 
    		price = 35;
	    else if (distance > 55 && distance <= 65)
		    price = 45;
    	else if (distance > 65 && distance <= 85)
    		price = 60;
	    else if (distance > 85)
           price = 80;
    } else if(vehicle == "Comfort") {
	    if (distance <= 55)
    		price = 38;
    	else if (distance > 55 && distance <= 65)
		    price = 48;
	    else if (distance > 65 && distance <= 85)
    		price = 63;
    	else if (distance > 85)
            price = 83;
    } else if(vehicle == "Minivan") {
	    if (distance <= 55)
		    price = 40;
	    else if (distance > 55 && distance <= 65)
    		price = 50;
    	else if (distance > 65 && distance <= 85)
		    price = 65;
	    else if (distance > 85)
    		price = 85;
    } else if(vehicle == "Minibus") {
	    if (distance <= 55)
    		price = 50;
    	else if (distance > 55 && distance <= 65)
		    price = 60;
	    else if (distance > 65 && distance <= 85)
    		price = 70;
    	else if (distance > 85)
	    	price = 100;
    } else if(vehicle == "Premium Minibus") {
	    if (distance <= 55)
    		price = 50;
    	else if (distance > 55 && distance <= 65)
		    price = 65;
	    else if (distance > 65 && distance <= 85)
    		price = 70;
    	else if (distance > 85)
            price = 95
    } else if(vehicle == "Premium") 
        price = 225;

        response.json(price);
});

const mysql = require('mysql');
const db = mysql.createConnection({
    host: 'localhost',
    user: 'dama-admin-db',
    password: 'damaPass',
    //user:'root',
    database: 'dama_taxi_db'
});

db.connect((err) => {
    if(err) console.error(err.message);
    else  
    console.log("Mysql connected");
});

//Insert booking.
app.get('/insertBooking/:data', async (request, response) => {
    let jsonData = JSON.parse(request.params['data']);    
    const query = "INSERT INTO `bookings`(`transfer_date`, `transfer_time`, `flightNumber`, `from_dest`, `to_dest`, `passengers`, `luggage`, `name`, `email`, `phone`, `vehicle`, `price`, `is_return`) VALUES ('" + jsonData.arrivalDate + 
    "', '" + jsonData.arrivalTime + "', '" + jsonData.flightNumber + "', '" + jsonData.from + "', '" + jsonData.to + "', " + jsonData.passengers +
     ", " + jsonData.luggage + ", '" + jsonData.name + "', '" + jsonData.email + "', '" + jsonData.phone + "', '" + jsonData.vehicle + "'," + jsonData.price + ", '" + jsonData.isReturn + "')";     
     db.query(query, (err, result) => {
         if(err) log.info(err.message);         
     });
     db.query("SELECT LAST_INSERT_ID() as book_id", (err, result) => {
        if(err) {
            log.info(err.message);
            response.send(err.message);
        }
        else {            
            response.json(result);
            log.info("Book "+ result[0].book_id + " has inserted");
        }
     });
});

//Insert return booking.
app.get('/insertReturnBooking/:data', async (request, response) => {
    let jsonData = JSON.parse(request.params['data']);    
    const query = "INSERT INTO `bookings`(`transfer_date`, `transfer_time`, `flightNumber`, `from_dest`, `to_dest`, `passengers`, `luggage`, `name`, `email`, `phone`, `vehicle`, `price`, `is_return`) VALUES ('" + jsonData.returnDate + 
    "', '" + jsonData.returnTime + "', '" + jsonData.flightNumber + "', '" + jsonData.to + "', '" + jsonData.from + "', " + jsonData.passengers +
     "," + jsonData.luggage + ", '" + jsonData.name + "', '" + jsonData.email + "', '" + jsonData.phone + "', '" + jsonData.vehicle + "'," + jsonData.price + ", '" + jsonData.isReturn + "')";     
     db.query(query, (err, result) => {
         if(err) log.info(err.message);         
     });
     db.query("SELECT LAST_INSERT_ID() as book_id", (err, result) => {
        if(err) {
            log.info(err.message);
            response.send(err.message);
        }
        else {            
            response.json(result);            
            log.info("Book "+ result[0].book_id+" has inserted (return)");
        }
     });
});

//Get the car list for booking page
app.get('/getCars', async (request, response) => {    
    const query = 'SELECT * FROM packages';
    db.query(query, (err, result) => {
        if (err) log.info(err.message);
        else {
        response.json(result);        
        }
    });
});

//Get all customers for admin panel
app.get('/getCustomers', async (req, res) => {
    if(auth) {
    const query = 'SELECT * FROM bookings ORDER BY submit_date DESC';
    db.query(query, (err, result) => {
        if (err) log.info(err.message);
        else {
        res.json(result);        
        }
    });
    } else {        
        res.redirect("/login-admin-panel.html");
        log.info("restricted area");
    }
});

//Send e-mail
const sgMail = require('@sendgrid/mail');

var template = fs.readFileSync('./public/checkoutEmail.hjs', 'utf-8');
var compiledTemplate = hogan.compile(template);

app.get('/sendEmail/:data', async function(request, response) {    
    let jsonData = JSON.parse(request.params['data']);        
    sgMail.setApiKey("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");
    console.log(jsonData);
    const emails = 
        {
           to: [jsonData.email, 'info@example.com'],
           from: 'info@example.com',
           fromname: 'Example Taxi',
           subject: 'Airport Transfer Receipt, Booking ID: ' + jsonData.book_id,
           html: compiledTemplate.render({book_id: jsonData.book_id, name: jsonData.name, phone: jsonData.phone, email: jsonData.email, from: jsonData.from,
               fromAddress: jsonData.fromAddress, to: jsonData.to, toAddress: jsonData.toAddress, flight_number: jsonData.flightNumber, arrival_date: jsonData.arrivalDate,
               arrival_time: jsonData.arrivalTime, vehicle: jsonData.vehicle, brand: jsonData.brand, image: jsonData.image, passengers: jsonData.passengers,
               luggage: jsonData.luggage, babySeat: jsonData.babySeat, price: jsonData.price})
        };

    sgMail.sendMultiple(emails).then(() => {
        log.info("E-mail sent to "+ jsonData.email);
        response.send("E-mail sent");
    }).catch((err) => {
        log.info(err);
        log.info(err.message);
        response.send(err.message);
    });
});

var returnTemplate = fs.readFileSync('./public/checkoutEmailReturn.hjs', 'utf-8');
var returnCompiledTemplate = hogan.compile(returnTemplate);

app.get('/sendReturnEmail/:data', function(request, response) {
    let jsonData = JSON.parse(request.params['data']);
    sgMail.setApiKey("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");
    //Customer
    let totalPrice = parseInt(jsonData.price) * 2;
    const emails = 
    {
       to: [jsonData.email, 'info@example.com],
       from: 'info@example.com',
       fromname: 'Example Taxi',
       subject: 'Airport Transfer Receipt, Booking ID: ' + jsonData.book_id,
       html: returnCompiledTemplate.render({book_id: jsonData.book_id, name: jsonData.name, phone: jsonData.phone, email: jsonData.email, from: jsonData.to,
        fromAddress: jsonData.fromAddress, to: jsonData.from, toAddress: jsonData.toAddress, flight_number: jsonData.flightNumber, arrival_date: jsonData.arrivalDate,
        arrival_time: jsonData.arrivalTime, return_date: jsonData.returnDate, return_time: jsonData.returnTime,
        vehicle: jsonData.vehicle, passengers: jsonData.passengers, luggage: jsonData.luggage, babySeat: jsonData.babySeat,
        brand: jsonData.brand, image: jsonData.image, price: jsonData.price, totalPrice: totalPrice})
    };

sgMail.sendMultiple(emails).then(() => {
        log.info("E-mail sent to "+ jsonData.email + " (return)");
        response.send("E-mail sent");
    }).catch((err) => {
        log.info(err.message);
        response.send(err.message);
    });
});


//Contact us mail
app.get('sendContactUs/:data', function(req, res) {
    let jsonData = JSON.parse(request.params['data']);
    sgMail.setApiKey("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");
    const email = 
    {
        to: 'info@example.com',
        from: 'info@example.com',
        fromname: 'Dama Taxi',
        subject: 'Contact Us',
        html: "<p>From: "+ jsonData.email +"</p><br><p>Name: " + jsonData.name +"</p><br><p>Phone: " +
         jsonData.phone +"</p><br><p>Message: "+ jsonData.message + "</p>"
    };
    sgMail.send(email);
});

//Login panel
app.post('/login-admin-panel', async (req, res) => {       
    let query = "SELECT pass FROM dama_admins WHERE user='"+req.body.username+"'";
    db.query(query, async (err, result) => {
        if(err) log.info(err.message);
        else {
            try {                
                if (await bcrypt.compare(req.body.password, result[0].pass)) {                    
                    auth = true;
                    res.redirect("/admin-panel.html");
                } else {
                    res.send("Wrong password");
                    auth = false;
                }                
            } catch {
                res.status(500).send();
            }
        }
    });

    /* GENERATE PASS
    const salt = await bcrypt.genSalt();
    const hashedPass = await bcrypt.hash(req.body.password, salt);
    log.info(salt);
    log.info(hashedPass);*/
    /*var salt = "$2b$10$ydr3fO.0KyR2aIpY9erpae";   
    log.info(bcrypt.hashSync(req.body.password, salt));*/
});

//404 redirect
/*app.use(function(req, res) {
    res.status(404).redirect("/404");
    
});*/

httpApp.get("*", function(req, res, next) {
    res.redirect("https://" + req.headers.host + req.path);
});

http.createServer(httpApp).listen(80, function() {
    console.log("Express HTTP server listening on port 80");
});

https.createServer(optionSSL, app).listen(443, function() {
    console.log("Express HTTPS server listening on port 443" );
});
