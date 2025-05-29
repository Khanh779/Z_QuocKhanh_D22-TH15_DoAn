function hideLoader() {
	document.getElementById('loader').style.opacity = 0;
	setTimeout(function () {
		document.getElementById('loader').style.display = 'none';
	}, 300);
}
// Hiện loader khi chuyển tab
const sidebarMenu = document.querySelectorAll('.sidebar-menu span');
for (let item of sidebarMenu) {
	item.addEventListener('click', function () {
		document.getElementById('loader').style.display = 'flex';
		document.getElementById('loader').style.opacity = 1;
	});
}

// Modal nhân viên
function openEditEmployeeModal(id, fullName, gender, dob, email, phone, address, departmentId, hireDate, position, userId) {
	document.getElementById('id').value = id;
	document.getElementById('fullName').value = fullName;
	document.getElementById('gender').value = gender;
	document.getElementById('dob').value = dob;
	document.getElementById('email').value = email;
	document.getElementById('phone').value = phone;
	document.getElementById('address').value = address;
	document.getElementById('departmentId').value = departmentId;
	document.getElementById('hireDate').value = hireDate;
	document.getElementById('position').value = position;
	document.getElementById('userId').value = userId;

	document.getElementById('modal').style.display = 'block';
	document.getElementById('editModal').style.display = 'block'; // unchanged
	document.getElementById('addModal').style.display = 'none'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

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


// Modal chấm công
function openAddAttendanceModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block'; // unchanged
	document.getElementById('editModal').style.display = 'none'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditAttendanceModal(id, employeeId, date, checkIn, checkOut) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none'; // unchanged
	document.getElementById('editModal').style.display = 'block'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('date').value = date;
	document.getElementById('attendanceId').value = id;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('checkIn').value = checkIn;
	document.getElementById('checkOut').value = checkOut;

}

// Modal nghỉ phép
function openAddLeaveModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block'; // unchanged
	document.getElementById('editModal').style.display = 'none'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditLeaveModal(id, employeeId, leaveType, startDate, endDate, status) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none'; // unchanged
	document.getElementById('editModal').style.display = 'block'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('id').value = id;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('leaveType').value = leaveType;
	document.getElementById('startDate').value = startDate;
	document.getElementById('endDate').value = endDate;
	document.getElementById('status').value = status;

}

// Modal hợp đồng
function openAddContractModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block'; // unchanged
	document.getElementById('editModal').style.display = 'none'; // unchanged
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditContractModal(id, employeeId, contractType, startDate, endDate, note) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'block';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('id').value = id;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('contractType').value = contractType;
	document.getElementById('startDate').value = startDate;
	document.getElementById('endDate').value = endDate;
	document.getElementById('note').value = note;

}


// Modal lương
function openAddSalaryModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block';
	document.getElementById('editModal').style.display = 'none';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditSalaryModal(id, employeeId, month, year, basicSalary, allowance, bonus, deduction) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'block';

	document.getElementById('salaryId').value = id;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('month').value = month;
	document.getElementById('year').value = year;
	document.getElementById('basicSalary').value = basicSalary;
	document.getElementById('allowance').value = allowance;
	document.getElementById('bonus').value = bonus;
	document.getElementById('deduction').value = deduction;


}

// Modal phòng ban
function openAddDepartmentModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block';
	document.getElementById('editModal').style.display = 'none';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditDepartmentModal(id, name, employeeId) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'block';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('id').value = id;
	document.getElementById('name').value = name;
	document.getElementById('employeeId').value = employeeId;

}

// Modal khen thưởng/kỷ luật
function openAddRewardsDisciplineModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block';
	document.getElementById('editModal').style.display = 'none';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditRewardsDisciplineModal(id, employeeId, type, date, title, description) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'block';
	//	document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('id').value = id;
	document.getElementById('employeeId').value = employeeId;
	document.getElementById('type').value = type;
	document.getElementById('dateRecored').value = date;
	document.getElementById('title').value = title;
	document.getElementById('description').value = description;

}

function openAddUserModal() {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'block';
	document.getElementById('editModal').style.display = 'none';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

}

function openEditUserModal(id, username, password, role) {
	document.getElementById('modal').style.display = 'block';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'block';
	//document.getElementById('messageModal').style.display = 'none'; // unchanged

	document.getElementById('id').value = id;
	document.getElementById('username').value = username;
	document.getElementById('password').value = password;
	document.getElementById('role').value = role;

}

// Modal 
function closeModal() {
	document.getElementById('modal').style.display = 'none';
	document.getElementById('addModal').style.display = 'none';
	document.getElementById('editModal').style.display = 'none';
	document.getElementById('messageModal').style.display = 'none';

}


function filterTableByFields(sourceObject, targetObject) {

	const rows = document.querySelectorAll(".table1 tr");

	for (let i = 1; i < rows.length; i++) {
		const row = rows[i];

		let isMatch = true;

		for (const key in sourceObject) {
			const keyword = sourceObject[key].trim().toLowerCase();
			const cellSelector = targetObject[key];
			if (!cellSelector) continue;

			const cell = row.querySelector(cellSelector);
			if (!cell) continue;

			const cellText = cell.textContent.trim().toLowerCase();

			// So sánh bao gồm
			if (keyword !== "" && !cellText.includes(keyword)) {
				isMatch = false;
				break;
			}
		}

		row.style.display = isMatch ? "" : "none";
	}
}



document.addEventListener("DOMContentLoaded", function () {


	// Lọc chấm công
	document.getElementById("filterDateView").addEventListener("input", function () {
		const selectedDate = (this.value);
		const rows = document.querySelectorAll(".table1 tr");

		for (let i = 1; i < rows.length; i++) {
			const row = rows[i];
			const rowDate = row.querySelector("#dateFiltered")?.textContent.trim();


			row.style.display = (selectedDate === "" || rowDate === selectedDate) ? "" : "none";
		}
	});

	// Lọc tìm kiếm theo tên, phòng ban, mã nhân viên.
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


	// ...existing code...

	document.addEventListener("DOMContentLoaded", function () {
		const modal = document.getElementById("messageModal");
		const closeBtn = document.getElementById("closeMessageModal");
		if (modal && closeBtn) {
			closeBtn.onclick = function () {
				modal.style.display = "none";
			};
			// Đóng modal khi click ra ngoài
			window.onclick = function (event) {
				if (event.target === modal) {
					modal.style.display = "none";
				}
			};
			// Tự động đóng sau 2.5s (nếu muốn)
			setTimeout(() => { if (modal.style.display === "block") modal.style.display = "none"; }, 2500);
		}
	});
});

