<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*"%>

<%
List<RewardsDiscipline> rewards = (ArrayList<RewardsDiscipline>) session.getAttribute("listRewardsDiscipline");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Danh sách khen thưởng và kỷ luật</title>
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
    <h1>Danh sách khen thưởng và kỷ luật <button class="primary-button" style="width: fit-content; margin-left: 5px;" onclick="openAddRewardsDisciplineModal()">Thêm mới</button></h1>
    <table class="table1">
        <tr>
            <th>ID</th>
            <th>ID nhân viên</th>
            <th>Loại</th>
            <th>TIêu đề</th>
            <th>Mô tả</th>
            <th>Ngày</th>
            <th>Hành động</th>
        </tr>

        <%
        if (rewards != null && rewards.size() > 0) {
            for (RewardsDiscipline reward : rewards) {
            	String reType=reward.getType();
            	reType= "reward".equalsIgnoreCase(reward.getType())? "Khen thưởng": "discipline".equalsIgnoreCase(reward.getType())?"Kỷ luật":"-";
        %>
        <tr>
            <td><%=reward.getRecordId() %></td>
            <td><%=reward.getEmployeeId()%></td>
            <td><%= reType %></td>
            <td><%=reward.getTitle() %></td>
            <td><%=reward.getDescription()%></td>
            <td><%=reward.getDateRecorded() %></td>
            <td>
              <button class="primary-button no-underline" style="padding: 5px 10px; width: fit-content;"
    				onclick="openEditRewardsDisciplineModal('<%=reward.getRecordId()%>', '<%=reward.getEmployeeId()%>', '<%=reward.getType()%>',
        				'<%=reward.getDateRecorded()%>', '<%=reward.getTitle()%>', '<%=reward.getDescription()%>' )">
						    Sửa
						</button>

                        
                <a href='${pageContext.request.contextPath}/deleteRewardDiscipline?id=<%=reward.getRecordId()%>' class="red-button no-underline"
                   onclick="return confirm('Bạn có chắc chắn muốn xóa không?')"
                   style="width: fit-content; padding: 5px 10px;">Xóa</a>
            </td>
        </tr>
        <%
            }
        } else {
        %>
        <tr>
            <td colspan="7" style="text-align: center;">Không có dữ liệu</td>
        </tr>
        <%
        }
        %>
    </table>
</div>

<!-- Modal chỉnh sửa khen thưởng/kỷ luật -->
<div id="modal" class="modal">

    <div id="editModal" class="editModal">
        <h2 style="margin-bottom: 10px;">Sửa khen thưởng/kỷ luật</h2>

        <form id="editForm" action="editRewardDiscipline" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
            <input type="hidden" name="id" id="id" />

            <!-- Cột trái -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>ID nhân viên:</label>
                <input type="text" id="employeeId" name="employeeId" required />

                <label>Loại:</label>
                <select name="type" id="type" required>
                    <option value="reward">Khen thưởng</option>
                    <option value="discipline">Kỷ luật</option>
                </select>

                <label>Ngày:</label>
                <input type="date" id="dateRecored" name="dateRecored" required />
            </div>

            <!-- Cột phải -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>Tiêu đề:</label>
                  <input type="text" id="title" name="title" required></input>

                <label>Mô tả:</label>
               <input type="text" id="description" name="description" required></input>
            </div>

            <!-- Nút hành động -->
            <div style="grid-column: span 2; text-align: right; margin-top: 5px;">
                <button class="primary-button" type="submit" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; cursor: pointer;">Lưu</button>
                <button class="red-button" type="button" onclick="closeModal()" style="width: fit-content; padding: 5px 15px; border: none; border-radius: 4px; margin-left: 10px; cursor: pointer;">Hủy</button>
            </div>
        </form>
    </div>
    
    <!-- Modal thêm khen thưởng/kỷ luật -->
<div id="addModal" class="addModal">
    <h2 style="margin-bottom: 10px;">Thêm khen thưởng/kỷ luật</h2>

    <form id="addForm" action="addRewardDiscipline" method="post" style="display: grid; grid-template-columns: 1fr 1fr; gap: 30px;">
        
		 <!-- Cột trái -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>ID nhân viên:</label>
                <input type="text" id="employeeId" name="employeeId" required />

                <label>Loại:</label>
                <select name="type" id="type" required>
                    <option value="reward">Khen thưởng</option>
                    <option value="discipline">Kỷ luật</option>
                </select>

                <label>Ngày:</label>
                <input type="date" id="dateRecored" name="dateRecored" required />
            </div>

            <!-- Cột phải -->
            <div style="display: flex; flex-direction: column; gap: 0px;">
                <label>Tiêu đề:</label>
                <input type="text" id="title" name="title" required></input>

                <label>Mô tả:</label>
                <input type="text" id="description" name="description" required></input>
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
