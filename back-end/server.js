const express=require('express');
const app=express();
const mysql = require('mysql');
const bodyParser=require('body-parser')


const port=process.env.PORT || 3000;

/*

FOR UNIFORMITY
KEEP DATABASE NAME AS asur
*/

const dbName="asur_copy"
const userName="root"
const passw="Arora@2412"//change this when using on your local machine


app.use(bodyParser.json());
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
  //req.params here as student id and return 
  // this is sample data
  //  {
   //   "student id": "xyz"
//     "Subject_ID": "CSD311",
//     "Subject_Name": "Artifical Intelligence",
//     "Classroom_ID": "B315",
//     "Teacher_ID": "zBL102",
//     "Start_Time": "14:00:00",
//     "End_Time": "15:00:00",
//     "Seats": 150,
//     "LIVE": "NL"
// "Instructor Name":"Name",
// "Student attendance":76,
//   },

  //CHANGE TABLE NAME
  const query = "SELECT * FROM subject";
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
  const query=`SELECT * from student where Roll_No= ${id}`
  connection.query(query, (error, results) => {
      if (error) throw error;
      // console.log(results);
      res.json(results);
    });

})


app.get('/api/getClassroomDetails', (req, res) => {
    // Assuming you have a database connection object named 'db'
    const coursecode = req.query.coursecode; // Access coursecode from the URL query params
    console.log('Received coursecode:', coursecode);
  
    // Replace 'student_table' with your actual student table name
    const query = `SELECT * FROM classroom WHERE room_id = (SELECT classroom_id FROM subject WHERE subject_id = '${coursecode}')`;
  
    connection.query(query, (err, results) => {
      if (err) {
        console.error('Error retrieving classroom details:', err);
        res.status(500).json({ error: 'Internal Server Error' });
        return;
      }
  
      // Assuming your classroom details are returned as an array of objects
      const classroomDetails = results[0]; // Get the first (and only) row
  
      if (!classroomDetails) {
        console.error(`Classroom not found for coursecode: ${coursecode}`);
        res.status(404).json({ error: 'Classroom not found' });
        return;
      }
  
      res.status(200).json({ classroomDetails });
    });
  });
  
  //the above login endpoint will post  image url from this endpoint

//POST IMAGE ENDPOINT WORKING SUCCESSFULLY
app.post('/api/image/:studentID',(req,res)=>{
  const id= req.params.studentID;
  const {image_url} = req.body;//send image url through body from front end
  console.log(req.body);

  const query = `UPDATE student
  SET picture_url = "${image_url}"
  WHERE Roll_No =${id} `;

  connection.query(query, [image_url], (error, results) => {
    if (error) throw error;
    res.send("image url updated successfully");
  });


})

//the above login endpoint will get image from this endpoint
app.get('/api/image/:studentID',(req,res)=>{
    const id= req.params.studentID;
    console.log(id)

    const query=`select picture_url from student where roll_no=${id}`

    connection.query(query, (error, results) => {
      if (error) throw error;
      // console.log(results);
      res.json(results);
    });
    

})


//this endpoint updates the Live column in subject table to L
app.post('/api/makeClassLive',(req,res)=>{
  const {course_id}=req.body
  console.log(req.body)

  const query = `UPDATE subject
  SET  LIVE= "L"
  WHERE subject_id="${course_id}" `;

  connection.query(query, [course_id], (error, results) => {
    if (error) throw error;
    res.send("Live updated successfully");
  });

})

//this endpoint updates the Live column in subject table to NL
app.post('/api/endClass',(req,res)=>{
  const {course_id}=req.body
  console.log(req.body)

  const query = `UPDATE subject
  SET  LIVE= "NL"
  WHERE subject_id="${course_id}" `;

  connection.query(query, [course_id], (error, results) => {
    if (error) throw error;
    res.send({"msg":"Class ended successfully"});
  });

})

//Tested working as expected
app.post('/api/markAttendance',(req,res)=>{
    //to insert attendance details into attendance table
    const{stud_id,course_id,date,attendance_status}=req.body
    console.log(req.body)

    //This query first tries to insert details. If details are already there it will update present or absent
    //This is useful in the sense suppose teacher wants to update attendance manually for some student
    //BE SURE TO SEND DATE FROM THE FRONT END IN YYYY-MM--DD FORMAT
    const query=`insert into attendance_details values(${stud_id},"${course_id}","${date}","${attendance_status}",0)
    on duplicate key update PorA="${attendance_status}"`

    connection.query(query,[stud_id,course_id,date,attendance_status],(error,results)=>{
      if (error) {throw error}
      else{
        res.send("Attendance marked successfully");
      }
      
    })
})

//to fetch data and display attendance details for that student
//working successfully
app.get('/api/getAttendance/:studentId',(req,res)=>{
    //to get attendance details and display it in app
    const id=req.params.studentId;
// need to get it  subject wise 
    //we can sort this by date if needed not doing it as of now
    const query=`select * from attendance_details where roll_no=${id}`

    connection.query(query, (error, results) => {
      if (error) throw error;
      console.log(results);
      res.json(results);
    });


})



app.listen(port,()=>{
    console.log(`listening on ${port}`);
});


//  LEFT ENDPOINTS 1. FOR  getting attendance summary subject wise for aa particular student
// 2. post api for posting newly registered student in student table  with enrolling that student in 5  courses
// post and get api for updating how many check points are passed by student


// use of firebase 1. auth 2. image storing 3.storing url of server 4. 