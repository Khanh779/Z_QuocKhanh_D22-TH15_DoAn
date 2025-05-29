<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*"%>


<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Báo cáo</title>

<link rel="stylesheet" href="./css/style.css">

<style>
body {
	position: absolute;
	padding: 20px;
}
</style>

</head>

<body>

	<div id="contentModal" name="contentModal">
		<h1>Báo cáo - thống kê</h1>
		<div style=" margin-top: 20px; gap: 10px;">
			<label>Chọn loại báo cáo:  </label> 
			<select style="margin-left: 10px; padding: 5px 12px;">
				<option value="1">Danh sách nhân viên theo thời gian</option>
				<option value="2">Bảng công/ tháng</option>
				<option value="3">Lương tổng hợp</option>
				<option value="4">Thống kê nghỉ phép/ hợp đồng</option>    
			</select>
			
		</div>
		
		<button class="nhiCute-button" style="Width: fit-content;">Tạo báo cáo</button>
		
	 
	</div>

	 

	<script src="./js/script.js"></script>
</body>

</html>