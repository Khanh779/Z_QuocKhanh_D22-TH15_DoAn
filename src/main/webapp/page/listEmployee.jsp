<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>


<% 
	List<Employee> emps = (ArrayList<Employee>) session.getAttribute("listEmployee");

%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Danh sách nhân viên</title>

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
			Danh sách nhân viên
				<button class="primary-button"
				style="width: fit-content; margin-left: 5px;"
				onclick="openAddEmployeeModal()">Thêm nhân viên</button>
		</h1>

		<div style="margin-top: 10px; gap: 10px;">
			<label>Tìm kiếm theo (Tên, Mã NV hoặc PB): </label> <input
				type="text" style="margin-left: 10px;" name="filterSearch"
				id="filterSearch"/>
		</div>
		
		<c:if test="${not empty sessionScope.errorMessage}">

			<div style="background-color: rgba(var(--danger), 0.2); color:rgba(var(--danger)); padding: 10px;">
				${ sessionScope.errorMessage}
			</div>
		</c:if>

		<table class="table1">
			<tr>
				<th>ID</th>
				<th>Họ tên</th>
				<th>Giới tính</th>
				<th>Ngày làm</th>
				<th>Email</th>
				<th>Số điện thoại</th>
				<th>Địa chỉ</th>
				<th>Phòng ban</th>
				<th>Ngày vào làm</th>
				<th>Chức vụ</th>
				<th>ID tài khoản</th>
				<th>Hành động</th>
			</tr>

			<% if (emps !=null && emps.size()> 0) {
								for (Employee emp : emps) {
								String gen= emp.getGender();
								gen = "M".equalsIgnoreCase(gen) ? "Nam" : "Nữ";

								%>
			<tr>
				<td id="td_empId"><%=emp.getEmployeeId()%></td>
				<td id="td_empFullName"><%=emp.getFullName()%></td>
				<td><%=gen%></td>
				<td><%=emp.getDob()%></td>
				<td><%=emp.getEmail()%></td>
				<td><%=emp.getPhone()%></td>
				<td><%=emp.getAddress()%></td>
				<td id="td_departId"><%=emp.getDepartmentId()%></td>
				<td><%=emp.getHireDate()%></td>
				<td><%=emp.getPosition()%></td>
				<td><%=emp.getUserId()%></td>
				<td>
					<button class="primary-button no-underline"
						onclick="openEditEmployeeModal('<%=emp.getEmployeeId()%>', '<%=emp.getFullName()%>', 
										'<%=emp.getGender()%>', '<%=emp.getDob()%>', '<%=emp.getEmail()%>',
										'<%=emp.getPhone()%>', '<%=emp.getAddress()%>', '<%=emp.getDepartmentId()%>',
										'<%=emp.getHireDate()%>', '<%=emp.getPosition()%>', '<%=emp.getUserId()%>')"
						style="padding: 5px 10px; width: fit-content;">Sửa</button> <a
					href="${pageContext.request.contextPath}/deleteEmployee?id=<%= emp.getEmployeeId() %>"
					class="red-button no-underline"
					style="width: fit-content; padding: 5px 10px;"
					onclick="return confirm('Bạn có chắc chắn muốn xóa không?');">
						Xóa </a>

				</td>
			</tr>
			<% } } else { %>
			<tr>
				<td colspan="12" style="text-align: center;">Không có dữ liệu</td>
			</tr>
			<% } %>
		</table>
	</div>

	<!-- Modal chỉnh sửa nhân viên -->
	<div id="modal" class="modal">

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 10px;">Sửa nhân viên</h2>

			<form id="editForm" action="editEmployee" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<input type="hidden" name="id" id="id" />

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Họ tên:</label> <input type="text" name="fullName"
						id="fullName" required /> <label>Giới tính:</label> <select
						name="gender" id="gender" required>
						<option value="M">Nam</option>
						<option value="F">Nữ</option>
					</select> <label>Ngày sinh:</label> <input type="date" name="dob" id="dob" required/>

					<label>Email:</label> <input type="email" name="email" id="email" required/>

					<label>Phone:</label> <input type="text" name="phone" id="phone" required />
				</div>

				<!-- Cột phải -->

				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Địa chỉ:</label> 
					<input type="text" name="address" id="address" required/> 
					<label>Phòng ban:</label> 
					<input type="text" name="departmentId" id="departmentId" required/> 
					<label>Ngày vào làm:</label> 
					<input type="date" name="hireDate" id="hireDate" required/> 
					<label>Chức vụ:</label> 
					<input type="text" name="position" id="position" required/> 
					<label>ID tài khoản:</label> 
					<input type="text" name="userId" id="userId" required/>
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
			<h2 style="margin-bottom: 10px;">Thêm nhân viên</h2>

			<form id="addForm" action="addEmployee" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Họ tên:</label> 
					<input type="text" name="fullName" id="fullName" required /> 
					<label>Giới tính:</label> 
					<select name="gender" id="gender" required>
						<option value="M">Nam</option>
						<option value="F">Nữ</option>
					</select> 
					<label>Ngày sinh:</label> 
					<input type="date" name="dob" id="dob" required/>
					<label>Email:</label> <input type="email" name="email" id="email" required/>
					<label>Phone:</label> <input type="text" name="phone" id="phone" required/>
				</div>

				<!-- Cột phải -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Địa chỉ:</label> 
					<input type="text" name="address" id="address" /> 
					<label>Phòng ban:</label> 
					<input type="text" name="departmentId" id="departmentId" /> 
					<label>Ngày vào làm:</label> 
					<input type="date" name="hireDate" id="hireDate" required/> 
					<label>Chức vụ:</label> 
					<input type="text" name="position" id="position" required/> 
					<label>ID
						tài khoản:</label> <input type="text" name="userId" id="userId" required/>


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
	<script>
	document.getElementById("filterSearch").addEventListener("input", function () {
		const keyword = this.value?.trim().toLowerCase();
		const rows = document.querySelectorAll(".table1 tr");

		for (let i = 1; i < rows.length; i++) {
			const row = rows[i];
			const empId = row.querySelector("#td_empId")?.textContent.trim().toLowerCase();
			const fullName = row.querySelector("#td_empFullName")?.textContent.trim().toLowerCase();
			const departId = row.querySelector("#td_departId")?.textContent.trim().toLowerCase();

			const isMatch = empId.includes(keyword) || fullName.includes(keyword) || departId.includes(keyword);

			row.style.display = isMatch || keyword === "" ? "" : "none";
		}
	});
	
	function openAddEmployeeModal() {
		//document.getElementById('employeeId').value = '';
		document.getElementById('fullName').value = '';
		document.getElementById('gender').value = 'M';
		document.getElementById('dob').value = '';
		document.getElementById('email').value = '';
		document.getElementById('phone').value = '';
		document.getElementById('address').value = '';
		document.getElementById('departmentId').value = '';
		document.getElementById('hireDate').value = '';
		document.getElementById('position').value = '';
		document.getElementById('userId').value = '';

		document.getElementById('modal').style.display = 'block';
		document.getElementById('addModal').style.display = 'block'; // unchanged
		document.getElementById('editModal').style.display = 'none'; // unchanged
		//document.getElementById('messageModal').style.display = 'none'; // unchanged

	}

	</script>
</body>

</html>