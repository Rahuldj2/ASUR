# ASUR - Attendance System Using Recognition

<p align="center">
  <a href="https://freeimage.host/" target="_blank">
    <img src="https://iili.io/JoWfxef.png" alt="ASUR Logo" width="200" height="210"/>
  </a>
</p>
## Overview
ASUR (Attendance System Using Recognition) is a comprehensive solution for automating classroom attendance tracking. Leveraging Flutter, Dart, JavaScript, Express.js, Rest API, and Firebase, the system incorporates geofencing, facial recognition, and real-time tracking to enhance classroom efficiency and improve attendance accuracy.

## Link to DownLoad App
https://drive.google.com/file/d/1lOX0XJ5lJLaQIj5bs_BUYHTiQhCPrrvR/view?usp=sharing


## Link For Teacher Side Site
https://asur-ams.vercel.app/

Demo credentials for teacher view :-   email :- asur@snu.edu.in      ||     password :-    asursnu



## Features

1. **Geofencing with Precise Location Tracking:**
   - A Flutter app utilizing Geolocator for geofencing to ensure precise classroom attendance marking.
   - Conducted research to obtain accurate user coordinates, employing location smoothing and the Haversine theorem.
   - Modeled the assumed classroom shape as an ellipse for improved accuracy.

2. **Facial Recognition for Secure Attendance:**
   - Implemented facial recognition technology to confirm attendance securely.
   - Used Firebase for authentication and image storage to enhance security measures.

3. **Comprehensive Backend:**
   - Utilized Express.js as the backend framework to handle server-side operations.
   - Employed MySQL for efficient database management, ensuring reliable storage and retrieval of attendance data.

4. **Real-time Attendance Tracking:**
   - Developed a Next.js website for teachers to control attendance.
   - Enabled real-time tracking of attendance, providing instant updates to teachers and administrators.

5. **Enhanced Classroom Efficiency:**
   - Improved student engagement through real-time attendance tracking.
   - Provided subject-wise percentages for a more comprehensive overview of attendance patterns.



## App Flow
<p align="center">
  <a href="https://freeimage.host/" target="_blank">
    <img src="https://iili.io/JoWFmu4.md.jpg" alt="App Flow" width="750" height="410"/>
  </a>
</p>

### 1. Professor Initiates Attendance
   - The professor initiates attendance by making the class "Live" using the ASUR app.

### 2. Students Start the Class
   - Students enter the classroom and initiate the attendance process by performing the first face scan at the beginning of the class.

### 3. Periodic Location Tracking
   - During the class, the ASUR app performs periodic location tracking to ensure students remain inside the class.

### 4. Attendance Criteria
   - To be marked present, a student must:
     - Perform the first face scan at the beginning of the class.
     - Be present for at least 75% of the class duration inside the class.
     - Complete the second face scan at the end of the class within 60 seconds.

### 5. Teacher Ends the Class
   - The professor ends the class using the ASUR app.

### 6. Notification to Students
   - A notification is sent to every student's phone, indicating that the class has ended and prompting them to perform the second face scan within 60 seconds.

### 7. Students Complete Second Face Scan
   - Students perform the second face scan within the specified time frame.

### 8. Attendance Marking
   - Based on the completion of the attendance criteria, the ASUR system automatically marks the attendance:
      - If all criteria are met, the student is marked as present.
      - If any criteria are not met, the student is marked as absent.


## Project Structure

- `front-end`: Contains the Flutter app for student attendance.
- `nextjs_website repo link `: https://github.com/punyamsingh/asur-next

## Installation

1. Clone the repository.
2. Set up the Flutter environment for the Flutter app.
3. Install dependencies for the Express.js backend and Next.js website.
4. Configure Firebase authentication and storage.

## Usage

1. Launch the Flutter app on student devices for automatic attendance marking.
2. Access the Next.js website for teacher attendance control.
3. Utilize the facial recognition feature for secure attendance confirmation.

<div style="white-space: nowrap; overflow-x: auto; overflow-y: hidden; width: 100%; display: inline-block;">
   <img src="https://iili.io/JoWuqZu.md.jpg" alt="Screenshot 1" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
    <img src="https://iili.io/JoWuda2.md.jpg" alt="Screenshot 2" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
    <img src="https://iili.io/JoWu2vS.md.jpg" alt="Screenshot 3" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
   <img src="https://iili.io/JoWuCCb.md.jpg" alt="Screenshot 4" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
  <img src="https://iili.io/JoWanMF.md.jpg" alt="Screenshot 5" style="width: 15%; height: 30%;margin-right: 20px; display: inline-block;">
    <img src="https://iili.io/JoWaKuV.md.jpg" alt="Screenshot 6" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
     <img src="https://iili.io/JoWaqZP.md.jpg" alt="Screenshot 7" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
     <img src="https://iili.io/JoWafwB.md.jpg" alt="Screenshot 8" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
    <img src="https://iili.io/JoWaCn1.md.jpg" alt="Screenshot 9" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
       <img src="https://iili.io/JoWufje.md.jpg" alt="Screenshot 10" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
     <img src="https://iili.io/JoWuKu9.md.jpg" alt="Screenshot 11" style="width: 15%; height: 30%; margin-right: 20px; display: inline-block;">
   

   
  
</div>






## Technologies Used

- **Frontend:**
  - Flutter
  - Dart

- **Backend:**
  - Express.js
  - Rest API

- **Database:**
  - MySQL

- **Authentication and Storage:**
  - Firebase

- **Web Interface:**
  - Next.js
## Contributors

- [Aayush Arora - Flutter Application ]
- [Rahul Jayaram - Server Side and Next.js Site]
- [Punyam Singh - FrontEnd of Site]




Feel free to contribute and improve the ASUR Attendance System!
