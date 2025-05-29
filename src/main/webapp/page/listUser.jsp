<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.*, dao.*" %>
<%
    List<User> users = (ArrayList<User>) session.getAttribute("listUser");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Danh sách tài khoản</title>
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
        <h1>Danh sách tài khoản 
        	<button class="primary-button" style="width: fit-content; margin-left: 5px;" onclick="openAddUserModal()">Thêm user</button>
        </h1>
        <table class="table1">
            <tr>
                <th>ID tài khoản</th>
                <th>Tên đăng nhập</th>
                <th>Mật khẩu</th>
                <th>Vai trò</th>
                <th>Hành động</th>
            </tr>
            <% if (users != null && users.size() > 0) {
                for (User user : users) {
            %>
                <tr>
                    <td><%=user.getUserId()%></td>
                    <td><%=user.getUsername()%></td>
                    <td><%=user.getPassword()%></td>
                    <td><%=user.getRole()%></td>
                    <td>
                        <button class="primary-button no-underline" style="width: fit-content; padding:5px 10px;" 
                                onclick="openEditUserModal('<%=user.getUserId()%>', '<%=user.getUsername()%>', '<%=user.getPassword()%>', '<%=user.getRole()%>')">
                            Sửa
                        </button>
                        <a href="${pageContext.request.contextPath}/deleteUser?id=<%= user.getUserId() %>" 
                           class="red-button no-underline" style="width: fit-content; padding:5px 10px;"
                          onclick="return confirm('Bạn có chắc chắn muốn xóa user-id &quot;<%= user.getUserId()%>&quot;không?')">
                            Xóa
                        </a>
                    </td>
                </tr>
            <% } } else { %>
                <tr>
                    <td colspan="5" style="text-align:center;">Không có dữ liệu</td>
                </tr>
            <% } %>
        </table>
    </div>

   <!-- Modal chỉnh sửa user -->
	<div id="modal" class="modal">

		<div id="editModal" class="editModal">
			<h2 style="margin-bottom: 10px;">Sửa User</h2>

			<form id="editForm" action="editUser" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

				<input type="hidden" name="id" id="id" />

				<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					
					<label>Tên User:</label> 
					<input type="text" name="username" id="username" required /> 
					
					<label>Mật khuẩ:</label> 
					<input type="text" name="password" id="password" required />
					
					<label>Quyền:</label> 
					<select name="role" id="role">
						<option value="admin">Quản trị (ADmin)</option>
						<option value="hr">Tuyển dụng (HR)</option>
						<option value="employee">Nhân viên (Employee)</option>
					</select> 
					
		
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
			<h2 style="margin-bottom: 10px;">Thêm User</h2>

			<form id="addForm" action="addUser" method="post"
				style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">

			<!-- Cột trái -->
				<div style="display: flex; flex-direction: column; gap: 0px;">
					
					<label>Tên User:</label> 
					<input type="text" name="username" id="username" required /> 
					
					<label>Mật khuẩ:</label> 
					<input type="text" name="password" id="password" required />
					
					<label>Quyền:</label> 
					<select name="role" id="role">
						<option value="admin">Quản trị (ADmin)</option>
						<option value="hr">Tuyển dụng (HR)</option>
						<option value="employee">Nhân viên (Employee)</option>
					</select> 
					
		
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
