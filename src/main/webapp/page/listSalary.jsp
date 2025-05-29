<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*"%>

<%
List<Salary> salaries = (ArrayList<Salary>) session.getAttribute("listSalary");
EmployeeDao ed= new EmployeeDao();
%>

<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Danh sách lương</title>
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
			Danh sách lương
			<button class="primary-button"
				style="width: fit-content; margin-left: 5px;"
				onclick="openAddSalaryModal()">Thêm lương</button>
		</h1>
		
		

		<table class="table1">
			<tr>
				<th>ID</th>
				<th>Nhân viên</th>
				<th>Tháng</th>
				<th>Năm</th>
				<th>Lương cơ bản</th>
				<th>Phụ cấp</th>
				<th>Thưởng</th>
				<th>Khấu trừ</th>
				<th>Tổng lương</th>
				<th>Hành động</th>
			</tr>

			<%
			if (salaries != null && salaries.size() > 0) {
				for (Salary salary : salaries) {
					
					Employee empid= ed.getEmployeeById(salary.getEmployeeId());
			%>
			<tr>
				<td><%=salary.getSalaryId()%></td>
				<td><%= empid!=null? empid.getEmployeeId() + " - "+ empid.getFullName() :"<>" %></td>
				<td><%=salary.getMonth()%></td>
				<td><%=salary.getYear()%></td>
				<td><%=salary.getBasicSalary() %></td>
				<td><%=salary.getAllowance()%></td>
				<td><%= salary.getBonus() %></td>
				<td><%= salary.getDeduction() %></td>
				<td><%=salary.getTotalSalary()%></td>
				<td>
					<button class="primary-button no-underline"
						onclick="openEditSalaryModal('<%=salary.getSalaryId()%>', '<%=salary.getEmployeeId()%>', 
                                            '<%=salary.getMonth()%>', '<%=salary.getYear()%>', 
                                            '<%=salary.getBasicSalary()%>', '<%=salary.getAllowance()%>',
                                            '<%=salary.getBonus()%>', '<%=salary.getDeduction()%>')"
						style="padding: 5px 10px; width: fit-content;">Sửa</button> <a
					href='${pageContext.request.contextPath}/deleteSalary?id=<%=salary.getSalaryId()%>'
					class="red-button no-underline"
					onclick="return confirm('Bạn có chắc chắn muốn xóa không?')"
					style="width: fit-content; padding: 5px 10px;">Xóa</a>
				</td>
			</tr>
			<%
			}
			} else {
			%>
			<tr>
				<td colspan="9" style="text-align: center;">Không có dữ liệu</td>
			</tr>
			<%
			}
			%>
		</table>
	</div>

	<!-- Modal chỉnh sửa lương -->
	<div id="modal" class="modal" >

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 10px;">Sửa thông tin lương</h2>

			<form id="editForm" action="editSalary" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
				<input type="hidden" name="salaryId" id="salaryId" />

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID hân viên:</label> <input type="text" id="employeeId"
						name="employeeId" required /> <label>Tháng:</label> <select
						name="month" id="editMonth" required>
						<option value="1">Tháng 1</option>
						<option value="2">Tháng 2</option>
						<option value="3">Tháng 3</option>
						<option value="4">Tháng 4</option>
						<option value="5">Tháng 5</option>
						<option value="6">Tháng 6</option>
						<option value="7">Tháng 7</option>
						<option value="8">Tháng 8</option>
						<option value="9">Tháng 9</option>
						<option value="10">Tháng 10</option>
						<option value="11">Tháng 11</option>
						<option value="12">Tháng 12</option>
					</select> <label>Năm:</label> <input type="number" id="year" name="year"
						required /> 

						<label>Thưởng:</label> <input type="number" id="bonus" name="bonus" required />

				</div>

				<!-- Cột phải -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Lương cơ bản:</label> <input type="number"
						id="basicSalary" name="basicSalary" required />
				
					<label>Phụ cấp:</label> <input type="number" id="allowance"
						name="allowance" required /> 

						<label>Khấu trừ:</label> <input type="number" id="deduction" name="deduction" required />

				
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

		<!-- Modal thêm lương -->
		<div id="addModal" class="addModal">
			<h2 style="margin-bottom: 10px;">Thêm thông tin lương</h2>

			<form id="addForm" action="addSalary" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID nhân viên:</label> 
						<input type="text" id="employeeId" name="employeeId" required />
						<label>Tháng:</label> 
						 
						<select name="month" id="month" required>
							<option value="1">Tháng 1</option>
							<option value="2">Tháng 2</option>
							<option value="3">Tháng 3</option>
							<option value="4">Tháng 4</option>
							<option value="5">Tháng 5</option>
							<option value="6">Tháng 6</option>
							<option value="7">Tháng 7</option>
							<option value="8">Tháng 8</option>
							<option value="9">Tháng 9</option>
							<option value="10">Tháng 10</option>
							<option value="11">Tháng 11</option>
							<option value="12">Tháng 12</option>
					</select> 
					<label>Năm:</label> 
					<input type="number" id="year" name="year" required />  

					<label>Khấu trừ:</label> 
					<input type="number" id="deduction" name="deduction" required /> 
				</div>

				<!-- Cột phải -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
				
				<label>Lương cơ bản:</label> <input type="number"
						id="basicSalary" name="basicSalary" required />
				
					<label>Phụ cấp:</label> <input type="number" id="allowance"
						name="allowance" required /> 

					<label>Thưởng:</label> <input type="number" id="bonus" name="bonus" required />

	
				</div>

				<!-- Nút hành động -->
				<div
					style="grid-column: span 2; text-align: right; margin-top: 5px;">
					<button class="primary-button" type="submit"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Thêm</button>
					<button class="red-button" type="button" onclick="closeModal()"
						style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>
				</div>
			</form>
		</div>

	</div>



	<script src="./js/script.js"></script>
</body>

</html>