<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.util.*, model.*, dao.*"%>
<%
List<Department> depts = (ArrayList<Department>) session.getAttribute("listDepartment");
EmployeeDao ed = new EmployeeDao();
%>
<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
			Danh sách phòng ban
			<button class="primary-button"
				style="width: fit-content; margin-left: 5px;"
				onclick="openAddDepartmentModal()">Thêm phòng ban</button>
		</h1>
		<table class="table1">
			<tr>
				<th>ID phòng ban</th>
				<th>Tên phòng ban</th>
				<th>ID quản lý (nhân viên)</th>
				<th>Hành động</th>
			</tr>

			<%
			if (depts != null && depts.size() > 0) {
				for (int i=0; i< depts.size(); i++) 
				{
					Department emp = depts.get(i);
					Integer empId = emp.getEmployeeId(); // employeeId có thể là null
					Employee e = (empId != null) ? ed.getEmployeeById(empId) : null;
					String emid = (empId != null) ? empId + " - " + (e != null ? e.getFullName() : "") : "<null>";

			%>
			<tr>
				<td><%=emp.getDepartmentId()%></td>
				<td><%=emp.getName()%></td>
				<td><%= emid%></td>
				<td>
					<!-- Sửa phòng ban -->
					<button class="primary-button no-underline"
						style="width: fit-content; padding: 5px 10px;"
						onclick="openEditDepartmentModal('<%=emp.getDepartmentId()%>', '<%=emp.getName()%>', '<%=emp.getEmployeeId()%>')">
						Sửa</button> <!-- Xóa phòng ban --> <a
					href="${pageContext.request.contextPath}/deleteDepartment?id=<%= emp.getDepartmentId() %>"
					class="red-button no-underline"
					style="width: fit-content; padding: 5px 10px;"
					onclick="return confirm('Bạn có chắc chắn muốn xóa phòng ban “<%= emp.getName() %> - <%= emp.getDepartmentId() %>” không?');">
						Xóa </a>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="4" style="text-align: center;">Không có dữ liệu</td>
			</tr>

			<%
			}
			%>
		</table>
	</div>

	<!-- Modal chỉnh sửa phòng ban -->
	<div id="modal" class="modal" >

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 15px;">Sửa phòng ban</h2>

			<form id="editForm" action="editDepartment" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
				
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<input type="hidden" name="id" id="id" />
				
					<label>Tên phòng ban:</label>
					<input type="text" name="name" id="name" required />
					
					<label>ID quản lý (Nhân viên):</label>
					<input type="text" name="employeeId" id="employeeId" />	
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
			<h2 style="margin-bottom: 10px;">Thêm phòng ban</h2>

			<form id="addForm" action="addDepartment" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<div style="display: flex; flex-direction: column; gap: 0px;">
				
					<label>Tên phòng ban:</label>
					<input type="text" name="name" id="name" required />
					
					<label>ID quản lý (Nhân viên):</label>
					<input type="text" name="employeeId" id="employeeId" />	
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

	<script src="./js/script.js"></script>
</body>

</html>