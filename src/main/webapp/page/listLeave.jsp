<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*, Utils.*"%>


<%
List<Leave> leaves = (ArrayList<Leave>) session.getAttribute("listLeave");
User user =(User)session.getAttribute("user");
EmployeeDao ed= new EmployeeDao();
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách nghỉ phép</title>
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
    <h1>Danh sách nghỉ phép <button class="primary-button" style="width: fit-content; margin-left: 5px;" onclick="openAddLeaveModal()">Gửi yêu cầu nghỉ</button></h1>
    <table class="table1">
        <tr>
            <th>ID</th>
            <th>ID nhân viên</th>
            <th>Loại nghỉ</th>
            <th>Ngày bắt đầu</th>
            <th>Ngày kết thúc</th>
            <th>Số ngày nghỉ còn lại</th>
            <th>Trạng thái</th>
            <th>Hành động</th>
        </tr>

        <%
        if (leaves != null && leaves.size() > 0) {
            for (Leave leave : leaves) {
            	Employee empid= ed.getEmployeeById(leave.getEmployeeId());
        %>
        <tr>
        	<%
	        	String sttus = leave.getStatus();
	        	sttus = "pending".equalsIgnoreCase(sttus) ? "Đang chờ" :
	        	        "approved".equalsIgnoreCase(sttus) ? "Đã duyệt" : "Từ chối";
	        	
	        	String typeLe= leave.getLeaveType();
	        	typeLe= "Phep".equalsIgnoreCase(typeLe) ? "Phép năm":
	        			"Khac".equalsIgnoreCase(typeLe) ?"Khác":"Bệnh";

        	%>
            <td><%=leave.getLeaveId()%></td>
            <td><%=empid!=null? empid.getEmployeeId() + " - "+ empid.getFullName() :"<>" %></td>
            <td><%=typeLe%></td>
            <td><%=leave.getStartDate()%></td>
            <td><%=leave.getEndDate()%></td>
            <td><%= Utility.daysLeft(leave.getEndDate()) %> </td>
            <td>
			  <div class="<%= 
			      "pending".equalsIgnoreCase(leave.getStatus()) ? "warning-status" :
			      "approved".equalsIgnoreCase(leave.getStatus()) ? "ok-status" : 
			      "error-status" %> padding-5">
			    <%= sttus %>
			  </div>
			</td>
            <td>
               <button class="primary-button no-underline" onclick="openEditLeaveModal('<%=leave.getLeaveId()%>', 
               '<%=leave.getEmployeeId()%>', '<%= leave.getLeaveType() %>', '<%=leave.getStartDate()%>', 
    				'<%=leave.getEndDate()%>', '<%=leave.getStatus()%>')" style="padding: 5px 10px; width: fit-content;">
						    Sửa
						</button>

                        
                <a href='${pageContext.request.contextPath}/deleteLeave?id=<%=leave.getLeaveId()%>' class="red-button no-underline"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa không?')"
                   style="width: fit-content; padding: 5px 10px;">Xóa</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="8" style="text-align: center;">Không có dữ liệu</td>
        </tr>
        <%
        }
        %>
    </table>
</div>

<!-- Modal chỉnh sửa nghỉ phép -->
<div id="modal" class="modal">

    <div id="editModal" class="editModal">
        <h2 style="margin-bottom: 10px;">Sửa đơn nghỉ</h2>

        <form id="editForm" action="editLeave" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
            <input type="hidden" name="id" id="id" />

            <!-- Cột trái -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>ID nhân viên:</label>
                <input type="number" id="employeeId" name="employeeId" required />

                <label>Loại nghỉ:</label>
                <select name="leaveType" id="leaveType" required>
                    <option value="Phep">Phép năm</option>
                    <option value="Khac">Khác</option>
                    <option value="Benh">Nghỉ ốm</option>
                </select>

                <label>Ngày bắt đầu:</label>
                <input type="date" id="startDate" name="startDate" required />
            </div>

            <!-- Cột phải -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>Ngày kết thúc:</label>
                <input type="date" id="endDate" name="endDate" required />

                <% if (!"employee".equalsIgnoreCase(user.getRole())) { %>
	            	<label>Trạng thái:</label>
			            <select name="status" id="status" required>
			                <option value="pending">Chờ duyệt</option>
			                <option value="approved">Đã duyệt</option>
			                <option value="rejected">Từ chối</option>
			            </select>
			     <%
	            	}
	            	else {
			     %>
			     	<input name="status" id="status" type="hidden" value="pending" required></input>
			     <% } %>

            </div>

            <!-- Nút hành động -->
            <div style="grid-column: span 2; text-align: right; margin-top: 5px;">
                <button class="primary-button" type="submit" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Lưu</button>
                <button class="red-button" type="button" onclick="closeModal()" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>
            </div>
        </form>
    </div>
    
    <!-- Modal thêm nghỉ phép -->
    <div id="addModal" class="addModal">
    <h2 style="margin-bottom: 10px;">Thêm đơn nghỉ</h2>

    <form id="addForm" action="addLeave" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
        <!-- Cột trái -->
        <div style="display: flex; flex-direction: column; gap: 0px;">
            <label>ID nhân viên:</label>
            <input type="number" id="employeeId" name="employeeId" required />

            <label>Loại nghỉ:</label>
            <select name="leaveType" id="leaveType" required>
                <option value="Phep">Phép năm</option>
                <option value="Khac">Khác</option>
                <option value="Benh">Nghỉ ốm</option>
            </select>

            <label>Ngày bắt đầu:</label>
            <input type="date" id="startDate" name="startDate" required />
        </div>

        <!-- Cột phải -->
        <div style="display: flex; flex-direction: column; gap: 0px;">
            <label>Ngày kết thúc:</label>
            <input type="date" id="endDate" name="endDate" required />

            <% if (!"employee".equalsIgnoreCase(user.getRole())) { %>
            	<label>Trạng thái:</label>
		            <select name="status" id="status" required>
		                <option value="pending">Chờ duyệt</option>
		                <option value="approved">Đã duyệt</option>
		                <option value="rejected">Từ chối</option>
		            </select>
		     <%
            	}
            	else {
		     %>
		     	<input name="status" id="status" type="hidden" value="pending" required></input>
		     <% } %>

        </div>

        <!-- Nút hành động -->
        <div style="grid-column: span 2; text-align: right; margin-top: 5px;">
            <button class="primary-button" type="submit" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Thêm</button>
            <button class="red-button" type="button" onclick="closeModal()" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>
        </div>
    </form>
</div>
</div>



<script src="./js/script.js"></script>
</body>
</html>
