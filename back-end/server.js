const express=require('express');
const app=express();


const port=process.env.PORT || 3000;

app.get('/api/getCourseList',(req,res)=>{
    //to get the course list from the subject table
})

app.get('/api/getProfile',(req,res)=>{
    //to get student details from student table
})

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