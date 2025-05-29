<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Đăng nhập</title>
<link rel="stylesheet" href="./css/style.css">
<style>
body {
	font-family: Arial, sans-serif;
	background: #f4f7f8;
	margin: 0px;
	padding: 0px;
	margin-top: -8%;
	height: 100vh;
	display: flex;
	justify-content: center;
	align-items: center;
	color: #333;
}

h3 {
	color: #2c3e50;
	text-align: center;
	margin-bottom: 20px;
}

form {
	background: #fff;
	width: 450px;
	heigth: 700px;
	padding: 20px 30px;
	border-radius: 8px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

label {
	font-weight: bold;
	margin-top: 5px;
	display: block;
}


button:hover {
	background-color: #1c5980;
}
</style>
</head>

<body>

	<form action="login" method="post">
		<h3>Đăng nhập</h3>
		<label for="username">Tên đăng nhập:</label> 
		<input type="text" style="padding: 8px 10px; font-size: 15px; width: 100%;"
			id="username" name="username" required value=""> 
			
		<label
			for="password">Mật khẩu:</label> 
			
		<input type="password" id="password" style="padding: 8px 10px; font-size: 15px; width: 100%;"
			name="password" required value="">
			
		<%
			Boolean isLogout = (Boolean) session.getAttribute("isLogout");
			if (isLogout != null && isLogout) {
			%>
			<div style="color: #FE9700;">Bạn đã đăng xuất</div>
			<%
			// Xóa biến lỗi sau khi hiển thị (tránh hiện lại khi F5)
				session.setAttribute("isFailed", false);
			}
		%>

		<%
			Boolean isFailed = (Boolean) session.getAttribute("isFailed");
			if (isFailed != null && isFailed) {
			%>
			<div style="color: #FF5D5B;">Đăng nhập thất
				bại. Vui lòng thử lại!</div>
			<%
			// Xóa biến lỗi sau khi hiển thị (tránh hiện lại khi F5)
				session.setAttribute("isFailed", false);
			}
		%>


		<button class="primary-button" style="padding: 10px 18px; margin-top: 16px; width: 100%;" type="submit">Đăng nhập</button>

	</form>
</body>

</html>