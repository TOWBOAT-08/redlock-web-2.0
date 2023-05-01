<?php
$servername = "localhost";
$username = "root";
$password = "password";
$dbname = "Redlock";

$conn = mysqli_connect($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected to MySQL success";
}

$sql = "SELECT COUNT(*) AS total FROM users";
$result = mysqli_query($conn, $sql);
$row = mysqli_fetch_assoc($result);
$total = $row["total"];
echo "Total user: " . $total;

mysqli_close($conn);
?>