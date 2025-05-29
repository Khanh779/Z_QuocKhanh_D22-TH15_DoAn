<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, model.*, dao.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
	List<Attendance> attendances = (ArrayList<Attendance>) session.getAttribute("listAttendance");
	User user= (User)session.getAttribute("user");
	//java.time.LocalDate today = java.time.LocalDate.now();
	
	EmployeeDao ed= new EmployeeDao();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách chấm công</title>
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
		<h1>
			Danh sách chấm công
			<button class="primary-button"
				style="width: fit-content; margin-left: 5px;"
				onclick="openAddAttendanceModal()">Thêm chấm công</button>
		</h1>
	
		<% if(user!=null && ("hr".equalsIgnoreCase(user.getRole()) || "admin".equalsIgnoreCase(user.getRole()))) { %>
			<div style="margin-top: 10px;">
				<label>Chọn ngày cần xem:</label>
				<input name="filterDateView" id="filterDateView" type="date" style="margin-left: 10px;" ></input>
			</div>
		<%} %>
			
		<c:if test="${not empty sessionScope.errorMessage}">

			<div style="background-color: rgba(var(--danger), 0.2); color:rgba(var(--danger)); padding: 10px;">
				${ sessionScope.errorMessage}
			</div>
		</c:if>

		<table class="table1">
			<tr>
				<th>ID chấm công</th>
				<th>ID nhân viên</th>
				<th>Ngày chấm công</th>
				<th>Check in (Giờ vào làm)</th>
				<th>Check out (Giờ ra về)</th>
				<th>Hành động</th>
			</tr>

			<%
			if (attendances != null && attendances.size() > 0) {
				for (Attendance attendance : attendances) {
					
					Employee empid= ed.getEmployeeById(attendance.getEmployeeId());
			%>
			<tr>
				<td><%=attendance.getAttendanceId()%></td>
				<td><%= empid!=null? empid.getEmployeeId() + " - "+ empid.getFullName() :"<>"  %></td>
				<td id="dateFiltered"><%=attendance.getDate()%></td>
				<td><%=attendance.getCheckIn()%></td>
				<td><%=attendance.getCheckOut()%></td>
				<td>
					<button class="primary-button no-underline"
						style="width: fit-content; padding: 5px 10px;"
						onclick="openEditAttendanceModal('<%=attendance.getAttendanceId()%>', '<%=attendance.getEmployeeId()%>', '<%=attendance.getDate()%>', '<%=attendance.getCheckIn()%>', '<%=attendance.getCheckOut()%>')">
						Sửa</button> <a
					href="${pageContext.request.contextPath}/deleteAttendance?id=<%= attendance.getAttendanceId() %>"
					class="red-button no-underline"
					style="width: fit-content; padding: 5px 10px;"
					onclick="return confirm('Bạn có chắc chắn muốn xóa chấm công "<%= attendance.getAttendanceId() %>" không?');">
						Xóa </a>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="6" style="text-align: center;">Không có dữ liệu</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

	<!-- Modal chỉnh sửa chấm công -->
	<div id="modal" class="modal">

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 10px;">Sửa chấm công</h2>

			<form id="editForm" action="editAttendance" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<input type="hidden" name="attendanceId" id="attendanceId" />

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID nhân viên:</label> 
					<input type="number" name="employeeId" id="employeeId" required /> 
						
					<label>Ngày chấm công:</label> <input type="date" name="date" id="date" required/>

					<label>Check in (Giờ vào):</label> <input type="time" name="checkIn" id="checkIn" required/>

					<label>Check out (Giờ ra):</label> <input type="time" name="checkOut" id="checkOut" required/>
				</div>

				<!-- Nút hành động -->
				<div
					style="grid-column: span 2; text-align: right; margin-top: 5px;">
					<button class="primary-button" type="submit"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Lưu</button>
					<button class="red-button" type="button" onclick="closeModal()"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>
				</div>
			</form>
		</div>


		<div id="addModal" class="addModal">
			<h2 style="margin-bottom: 10px;">Thêm chấm công</h2>

			<form id="addForm" action="addAttendance" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID nhân viên:</label> 
					<input type="number" name="employeeId" id="employeeId" required /> 
						
					<label>Ngày chấm công:</label> <input type="date" name="date" id="date" required/>

					<label>Check in (Giờ vào):</label> <input type="time" name="checkIn" id="checkIn" required/>

					<label>Check out (Giờ ra):</label> <input type="time" name="checkOut" id="checkOut" required/>
				</div>


				<!-- Nút hành động -->
				<div
					style="grid-column: span 2; text-align: right; margin-top: 5px;">
					<button class="primary-button" type="submit"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Lưu</button>
					<button class="red-button" type="button" onclick="closeModal()"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>

				</div>
			</form>

		</div>

	</div>



	<script src="./js/script.js">

    </script>
</body>
</html>