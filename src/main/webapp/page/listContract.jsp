<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*, Utils.*"%>

<%
List<Contract> contracts = (ArrayList<Contract>) session.getAttribute("listContract");

%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách hợp đồng</title>
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
        <h1>Danh sách hợp đồng <button class="primary-button" style="width: fit-content; margin-left: 5px;" onclick="openAddContractModal()">Thêm hợp đồng</button></h1>
        <table class="table1">
            <tr>
                <th>ID</th>
                <th>ID nhân viên</th>
                <th>Loại hợp đồng</th>
                <th>Ngày bắt đầu</th>
                <th>Ngày kết thúc</th>
                <th>Ghi chú</th>
                <th>Tình trạng</th>
                <th>Hành động</th>
            </tr>
            <% if (contracts != null && contracts.size() > 0) { 
                for (Contract contract : contracts) { boolean isExpired= Utility.isExpired(contract.getEndDate()); %>
            <tr>
                <td><%=contract.getContractId()%></td>
                <td><%=contract.getEmployeeId()%></td>
                <td><%=contract.getContractType()%></td>
                <td><%=contract.getStartDate()%></td>
                <td><%=contract.getEndDate()%></td>
                <td><%=contract.getNote()%></td>
               	<td>
				    <%
				        if (Utility.isExpired(contract.getEndDate())) {
				    %>
				        <div class="padding-5 error-status user-no-select">Hết hạn</div>
				    <%
				        } else {
				    %>
				        <div class="padding-5 ok-status user-no-select">Còn hạn</div>
				    <%
				        }
				    %>
				</td>

                <td>
                   <button class="primary-button no-underline" style="width: fit-content; padding:5px 10px;" 
    						onclick="openEditContractModal( '<%=contract.getContractId()%>', '<%=contract.getEmployeeId()%>', '<%=contract.getContractType()%>', 
    						'<%=contract.getStartDate()%>', '<%=contract.getEndDate()%>',  '<%=contract.getNote()%>')">
						    Sửa/ Gia hạn
						</button>

				<a href="${pageContext.request.contextPath}/deleteContract?id=<%= contract.getContractId() %>" 
				   class="red-button no-underline" style="width: fit-content; padding:5px 10px;"
				   onclick="return confirm('Bạn có chắc chắn muốn xóa hợp đồng với ID &quot;<%= contract.getContractId() %>&quot; không?')">
				    Xóa
				</a>

                </td>
            </tr>
            <% } 
            } else { %>
            <tr><td colspan="7" style="text-align:center;">Không có hợp đồng nào.</td></tr>
            <% } %>
        </table>
    </div>
   
  
  <!-- Modal chỉnh sửa nhân viên -->
	<div id="modal" class="modal">

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 10px;">Sửa/ gia hạn hợp đồng</h2>

			<form id="editForm" action="editContract" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<input type="hidden" name="id" id="id" />

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID nhân viên:</label> 
					<input type="number" name="employeeId" id="employeeId" required /> 
					
					<label>Loại hợp đồng:</label> 
					<input type="text" name="contractType" id="contractType" required /> 
					
					<label>Ghi chú:</label> 
					<input type="text" name="note" id="note" required /> 
				</div>
				
				<!-- Cột phải -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Ngày bắt đầu:</label> 
					<input type="date" name="startDate" id="startDate" required /> 
					
					<label>Ngày kết thúc:</label> 
					<input type="date" name="endDate" id="endDate" required />
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
			<h2 style="margin-bottom: 10px;">Thêm hợp đồng</h2>

			<form id="addForm" action="addContract" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>ID nhân viên:</label> 
					<input type="number" name="employeeId" id="employeeId" required /> 
					
					<label>Loại hợp đồng:</label> 
					<input type="text" name="contractType" id="contractType" required /> 
					
					<label>Ghi chú:</label> 
					<input type="text" name="note" id="note" required /> 
				</div>
				
				<!-- Cột phải -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					<label>Ngày bắt đầu:</label> 
					<input type="date" name="startDate" id="startDate" required /> 
					
					<label>Ngày kết thúc:</label> 
					<input type="date" name="endDate" id="endDate" required />
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
