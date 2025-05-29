<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.*"%>
<%
User user = (User) session.getAttribute("user");
if (user == null) {
	response.sendRedirect("index.jsp");
	return;
}
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Giao diện chính</title>

<link rel="preload" href="./css/style.css" as="style"
	onload="this.onload=null;this.rel='stylesheet'">

<link rel="preload" href="./css/style.css" as="style"
	onload="this.onload=null;this.rel='stylesheet'">
<noscript>
	<link rel="stylesheet" href="./css/style.css">
</noscript>

<script src="./js/script.js" defer></script>



<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />





<style>
body {
	display: flex;
	height: 100vh;
}
</style>
</head>

<body>

	<div class="sidebar">
		<h2>
			HR Manager<br>(Quốc Khánh - D22_TH15)
		</h2>
		<ul class="sidebar-menu">
			<li><span onclick="document.getElementById('page').src='home'"><i
					class="fa-solid fa-house"></i> Trang chủ</span></li>
			<li><span
				onclick="document.getElementById('page').src='employeeManager'"><i
					class="fa-solid fa-user"></i> Nhân viên</span></li>
			<li><span
				onclick="document.getElementById('page').src='departmentManager'"><i
					class="fa-solid fa-building"></i> Phòng ban</span></li>
			<li><span
				onclick="document.getElementById('page').src='attendanceManager'"><i
					class="fa-solid fa-clipboard-user"></i> Chấm công</span></li>
			<li><span
				onclick="document.getElementById('page').src='salaryManager'"><i
					class="fa-solid fa-dollar-sign"></i> Quản lý lương</span></li>
			<li><span
				onclick="document.getElementById('page').src='leaveManager'"><i
					class="fa-solid fa-arrow-right-from-bracket"></i> Nghỉ phép</span></li>
			<li><span
				onclick="document.getElementById('page').src='contractManager'"><i
					class="fa-solid fa-file-contract"></i> Hợp đồng</span></li>
			<li><span
				onclick="document.getElementById('page').src='rewardManager'"><i
					class="fa-solid fa-hand-holding-heart"></i> Khen thưởng - Kỷ luật</span></li>
			<li><span
				onclick="document.getElementById('page').src='viewReport'"><i
					class="fa-solid fa-square-poll-vertical"></i> Báo cáo - thống kê</span></li>
		</ul>


	</div>

	<div id="loader">
		<div class="loader-spinner"></div>
	</div>

	<div style="flex: 1; margin: 0px; padding: 0px;">
		<div class="nav-hor" style="display: flex; width: 100%">
			<h2 style="position: absolute; color: rgba(var(--text-secondary)); left: 10px;">
				Xin chào,
				<%=user.getUsername()%>
				(<%=user.getUserId()%>) -
				<%=user.getRole()%></h2>

			<button class="nhiCute-button"
				onclick="document.getElementById('page').src='userManager'"
				style="padding: 8px 10px; position: absolute; right: 120px; width: fit-content;">User
				Test</button>

			<button onclick="window.location.href='logout'" class="red-button"
				style="padding: 8px 10px; position: absolute; right: 5px; width: 110px;">Đăng
				xuất</button>
		</div>

		<div class="container-tabPage">

			<iframe src="home" class="tabPage border-none" name="page" id="page"
				onload="hideLoader()"></iframe>
			<script src="./js/script.js" defer></script>
		</div>


	</div>


</body>

</html>