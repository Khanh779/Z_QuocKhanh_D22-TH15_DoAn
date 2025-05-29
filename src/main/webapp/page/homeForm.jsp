<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.util.*, model.*, dao.*, Utils.*"%>




<!DOCTYPE html>
<html>

<head>
<meta charset="UTF-8">
<title>Trang chủ</title>
<link rel="stylesheet"
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.7.2/css/all.min.css"
	integrity="sha512-Evv84Mr4kqVGRNSgIGL/F/aIDqQb7xQ2vcrdIwxfjThSH8CSR7PBEakCr51Ck+w+/U6swU2Im1vVX0SVk9ABhg=="
	crossorigin="anonymous" referrerpolicy="no-referrer" />
<link rel="stylesheet" type="text/css" href="./css/style.css">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.js"></script>

<style>
body {
	display: flex;
	align-items: center;
	justify-content: center;
	margin: 0px;
	padding: 0px;
	height: 100%;
	width: 100%;
}

.container-sec {
	display: flex;
	flex-wrap: wrap;
	align-items: center;
	justify-content: center;
	padding-top: 20px;
}

.makeup-con_sec {
	margin: 20px;
	background: #fff;
	border-radius: 10px;
	box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
}

.card_sec {
	width: 300px;
	align-items: center;
	color: rgba(var(--text-secondary));
	overflow: hidden;
}

.card_sec h3 {
	margin-top: 5px;
	font-size: 20px;
	color: rgba(var(--primary)) !important;
}

.card_sec>div {
	margin-left: 20px;
}

.card_sec>i {
	font-size: 30px;
	margin-left: -15px;
}

.dis-flex {
	display: flex;
}
</style>

</head>

<body>

	<%
		List<User> accounts = (ArrayList<User>) session.getAttribute("listUser");
		List<Employee> employees = (ArrayList<Employee>) session.getAttribute("listEmployee");
		List<Department> departments = (ArrayList<Department>) session.getAttribute("listDepartment");
		List<Salary> salaries = (ArrayList<Salary>) session.getAttribute("listSalary");
		List<Leave> leaves = (ArrayList<Leave>) session.getAttribute("listLeave");
		List<Attendance> attendances = (ArrayList<Attendance>) session.getAttribute("listAttendance");
		List<Contract> contracts = (ArrayList<Contract>) session.getAttribute("listContract");
		List<RewardsDiscipline> rewardsDisciplines = (ArrayList<RewardsDiscipline>) session .getAttribute("listRewardsDiscipline");
		
		
		int leavePending=0; 
		int leaveApproved=0;
		int leaveRejected=0;
		
		for(int i=0; i< leaves.size(); i++)
		{
			Leave ct= leaves.get(i);
			if("approved".equalsIgnoreCase( ct.getStatus()))
			{
				leaveApproved++;
			}
			else if("pending".equalsIgnoreCase( ct.getStatus()))
			{
				leavePending++;
			}
			else{
				leaveRejected++;
			}
			
		}
		
	%>

	<div class="container container-sec user-no-select">

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">

			<i class="fa-solid fa-user"></i>

			<div>
				<h4>Số người dùng</h4>
				<h3>
					<%=accounts.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-user-tie"></i>
			<div>
				<h4>Số nhân viên</h4>
				<h3>
					<%=employees.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-building"></i>
			<div>
				<h4>Số phòng ban</h4>
				<h3>
					<%=departments.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">

			<%
			double totalSalary = 0;
			int currentMonth = 0;
			Date currentDate = new Date();
			currentMonth = currentDate.getMonth() + 1;
			for (int i = 0; i < salaries.size(); i++) {
				if (salaries.get(i).getMonth() == currentMonth)
					totalSalary += salaries.get(i).getTotalSalary();
			}
			%>
			<i class="fa-solid fa-dollar-sign"></i>
			<div>
				<h4>
					Lương chi của tháng
					<%=currentMonth%>
				</h4>
				<h3>
					<%=totalSalary%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-clipboard-user"></i>
			<div>
				<h4>Chấm công</h4>
				<h3>
					<%=attendances.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-file-contract"></i>
			<div>
				<h4>Hợp đồng</h4>
				<h3>
					<%=contracts.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-person-walking-arrow-right"></i>
			<div>
				<h4>Nghỉ phép</h4>
				<h3>
					<%=leaves.size()%>
				</h3>
			</div>
		</div>

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex">
			<i class="fa-solid fa-hand-holding-heart"></i>
			<div>
				<h4>Khen thưởng - Kỷ luật</h4>
				<h3>
					<%=rewardsDisciplines.size()%>
				</h3>
			</div>
		</div>
		
		
		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex"
			style="max-width: unset; display: flex; flex-direction: column; width: 800px; height: 400px; padding: 0px;">

			<h4 style="display: flex; gap: 5px; width: 100%; height: 50px; background-color: rgba(var(--warning)); 
				color: #fff; padding: 5px 10px; align-items: center;" >
			    <i class="fa-solid fa-circle-exclamation" style="font-size: 20px;"></i> Hợp đồng đến hạn
			  </h4>

			<div style="width: 100%; height: 100%; padding: 20px; margin: 0px; overflow: hidden; overflow-y: auto;">
				<table class="table1" style="margin:0px;">
					  <tr>
					    <th>ID</th>
					    <th>ID NV</th>
					    <th>Loại HĐ</th>
					    <th>Ngày KT</th>
					  </tr>
					  
					  
					  <% 
					    if (contracts != null && contracts.size() > 0) { 
					      for (int i=0; i< contracts.size(); i++) { 
					        Contract contract= contracts.get(i);
					        if (contract.getEndDate().equals(Utility.getCurrentDate().plusDays(1))) {
					  %>
					    <tr>
					      <td><%= contract.getContractId() %></td>
					      <td><%= contract.getEmployeeId() %></td>
					      <td><%= contract.getContractType() %></td>
					      <td><%= contract.getEndDate() %></td>
					    </tr>
					  <% 
					        }
					      } 
					    } else { 
					  %>
					    <tr>
					      <td colspan="7" style="text-align: center;">Không có hợp đồng nào đến hạn.</td>
					    </tr>
					  <% 
					    } 
					  %>
					</table>

			</div>

		</div>
		

		<div
			class="makeup-container makeup-con_sec card_sec user-no-select cursor-pointer dis-flex"
			style="width: 600px; height: 400px; padding: 10px;">
			<canvas id="myChart" style="width: 300px; max-width: 600px"></canvas>
		</div>
		
		
	</div>

	<script>
		var xValues = ["Đang chờ duyệt", "Đã duyệt", "Từ chối"];
		var yValues = [<%=leavePending%>, <%= leaveApproved%>, <%=leaveRejected%>];
		var barColors = [
		  "#f4c430",  
		  "#4CAF50", 
		  "#FF6B6B"  
		];
	
		new Chart("myChart", {
		  type: "pie",
		  data: {
		    labels: xValues,
		    datasets: [{
		      backgroundColor: barColors,
		      data: yValues
		    }]
		  },
		  options: {
		    title: {
		      display: true,
		      text: "Thông tin nghỉ phép"
		    }
		  }
		});

	</script>
</body>

</html>