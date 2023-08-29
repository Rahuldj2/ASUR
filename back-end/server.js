const express=require('express');
const app=express();
const mysql = require("mysql");


const port=process.env.PORT || 3000;

//Yagay fill your database details
const dbName=""
const userName=""
const passw=""

const connection = mysql.createConnection({
    host: "localhost",
    user: userName,
    password: passw,//my database password
    database: dbName,
  });

  connection.connect(function(err) {
    if (err) throw err;
    console.log("Connected!");
  });


app.get('/api/getCourseList',(req,res)=>{
    //to get the course list from the subject table

    //CHANGE TABLE NAME
    const query = "SELECT * FROM subject_table";
    connection.query(query, (error, results) => {
    if (error) throw error;
    // console.log(results);
    res.json(results);
  });
})

app.get('/api/getProfile/:studentID',(req,res)=>{
    //to get student details from student table


    //CHANGE STUDENT TABLE NAME IF NEEDED ACC TO YOUR DB
    const id= req.params.studentID;
    const query=`SELECT * from student_table where student_id= ${id}`
    connection.query(query, (error, results) => {
        if (error) throw error;
        // console.log(results);
        res.json(results);
      });

})


//FOR USER AUTHENTICATION
/*
initial sign up process
1. First ask for user email ID and set password
(store hash of password create student id and store in database)
2. Then ask user to register his face
3. Store this data in sql table
*/
app.post('/api/createAccount',(req,res)=>{
    //to create account AAYUSH dekh le
})

//sign in process
//get image data from sql
//compare with current captured image
app.get('/api/login',(req,res)=>{

})


//the above login endpoint will get image from this endpoint
app.get('/api/image/:studentID',(req,res)=>{

})

//later
app.post('/api/markAttendance',(req,res)=>{
    //to insert attendance details into attendance table
    //need to generate unique ID based on date or row number
})

app.get('/api/getAttendance',(req,res)=>{
    //to get attendance details and display it in app
})



app.listen(port,()=>{
    console.log(`listening on ${port}`);
});