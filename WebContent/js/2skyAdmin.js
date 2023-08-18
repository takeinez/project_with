//		let company_id;
		let file_name;
		let employee_id;
		let UserList;
		let defalut_name;
		let p_name;
		let p_id;
//		let project_id;
		
	
//		function company_information_load() {
//			$.ajax({
//	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
//	            type: "POST",		// 데이터를 가져오는 방식
//	            data: {
//	            	send_number: 1,
//	            	send_id: "jam010"
//	            	},
//	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
//	                console.log(data);
//	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
//// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
//	                for (var i = 0; i < json.length; i++) {
//	                	company_id = json[i].company_id;
//// 	                	alert("company" + company_id);
//	                	let company_name = json[i].company_name;
//	                	let company_URL = json[i].company_URL;
//	                	let company_img = json[i].company_img;
//	                	let company_join_option = json[i].company_join_option;
//// 	                    alert(company_join_option);
//	                    $("#comm input").val(company_name);
//	                    $(".inlogoimg img").attr("src", company_img);
//	                    $(".inlogoimg img").attr("name", "title_img");
//		      	    	$("[name='title_img']").attr("style", "position: relative; max-height: 55px; max-width: 280px;");
//		      	    	$("#file_box").html('<img src="' + company_img + '" alt="" style="transform: translateY(-50%); top: 50%; position: relative; max-height: 142px; max-width: 408px;" thum_img_path="https://flow.team/flowImg/FLOW_202306143129656_b1d7faa3-08eb-48c7-8244-3d7bca88df81.png" atch_srno="53291875">');
//		      	    	$("#domain input").val(company_URL);
//		      	    	if(company_join_option==null) {
//		      	    		$("#teamSet1").attr("checked" , "")
//		      	    	} else {
//		      	    		$("#teamSet2").attr("checked" , "")
//		      	    		$("#comm_domain input").val(company_join_option);
//		      	    		$("#comm_domain").css("display", "inline-block");
//		      	    	}
//		      	    	
//	                }
//	            }
//	        })
//		}
		
		function project_manage_load() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 2,
	            	send_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
					$("#useStatPrjScroll tbody").html("");
					let i = 0;
	                for (i = 0; i < json.length; i++) {
	                	let project_name = json[i].project_name;
	                	project_id = json[i].project_id;
	                	let recent_date = json[i].recent_date;
	                	let project_birthday = json[i].project_birthday;
	                	let project_member_count = json[i].project_member_count;
	                	let project_admin_count = json[i].project_admin_count;
	                	let project_admin_name_1 = null;
	                	if(project_admin_count>=1) {
	                		project_admin_name_1 = json[i].project_admin_name_1;
	                	}
	                	let board_count = json[i].board_count;
	                	let reply_count = json[i].reply_count;
	                	let chat_count = json[i].chat_count;
	                	let schedule_count = json[i].schedule_count;
	                	let work_count = json[i].work_count;
	                	
	                	if(project_admin_count>=2) {
	                		let project_admin_count_ = project_admin_count-1;
	                		let employees = project_member_count - project_admin_count;
	                		$("#useStatPrjScroll tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                "<td>"+project_name+"</td>"+
	                                "<td>"+project_admin_name_1+"외 " + project_admin_count_ + "명</td>"+
	                                "<td>"+project_member_count+"</td>"+
	                                "<td>"+employees+"</td>"+
	                                "<td>"+board_count+"</td>"+
	                                "<td>"+reply_count+"</td>"+
	                                "<td>"+chat_count+"</td>"+
	                                "<td>"+schedule_count+"</td>"+
	                                "<td>"+work_count+"</td>"+
	                                "<td>"+recent_date+"</td>"+
	                                "<td>"+project_birthday+"</td>"+
	                                "</tr>");
	                	} else {
	                		let employees = project_member_count - project_admin_count;
		                	$("#useStatPrjScroll tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                "<td>"+project_name+"</td>"+
	                                "<td>"+project_admin_name_1+"</td>"+
	                                "<td>"+project_member_count+"</td>"+
	                                "<td>"+employees+"</td>"+
	                                "<td>"+board_count+"</td>"+
	                                "<td>"+reply_count+"</td>"+
	                                "<td>"+chat_count+"</td>"+
	                                "<td>"+schedule_count+"</td>"+
	                                "<td>"+work_count+"</td>"+
	                                "<td>"+recent_date+"</td>"+
	                                "<td>"+project_birthday+"</td>"+
	                                "</tr>");
	                	}
	                }
	                
	                $('#useStatPrjScroll td').each(function() {
					    if($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
	                
	                if(i==0) {
                		$("#useStatPrjScroll tbody").append('<tr style="cursor: pointer; background-color: rgb(255, 255, 255);">'+
                				"<td  colspan='11'>"+"결과값이 존재하지 않습니다."+"</td>"+
                				"</tr>");
                	}
	            }
	        })
		}
		
		
		function employees_manage_load() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 7,
	            	send_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
					$("#normalUserList").html("");
					$("#stopUserList").html("");
					$("#joinUserList").html("");
					let useCnt = 0;
					let stopCnt = 0;
					let joinCnt = 0;
	                for (var i = 0; i < json.length; i++) {
	                	let company_name = json[i].company_name;
	                	let employee_name = json[i].employee_name;
	                	let department_name = json[i].department_name;
	                	let job_title = json[i].job_title;
	                	employee_id = json[i].employee_id;
	                	let phone = json[i].phone;
	                	let join_date = json[i].join_date;
	                	let status = json[i].status;
	                	let company_admin = json[i].company_admin;
						if(status==1) {
							$("#normalUserList").append('<tr user_id="' + employee_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                '<td class="js-user-check"><input type="checkbox"></td>' +
	                                '<td class="cn">' + company_name + '</td>' +
	                                '<td class="nm">' + employee_name + '</td>' +
	                                '<td class="dv">' + department_name + '</td>'+
	                                '<td class="jb">' + job_title + '</td>' +
	                                '<td class="em">' + employee_id + '</td>'+
	                                '<td class="hp">' + phone + '</td>'+
	                                '<td>' + join_date + '</td>'+
	                                "<td>"+""+"</td>"+
	                                "<td>"+""+"</td>"+
	                                "<td>"+""+"</td>"+
	                                '<td>2&nbsp;<a class="tbold_uline">[보기]</a></td>'+
	                                '<td stts="Y">정상&nbsp;<a class="tbold_uline">[이용중지]</a></td>'+
	                                '<td mngr-dscn="F" style="font-weight: bold;"><span>Y</span>&nbsp;&nbsp;<a class="tbold_uline" style="color: rgb(255, 0, 0);">[삭제]</a></td>'+
	                                "</tr>");
							if(company_admin==0) {
								$('#normalUserList tr[user_id="' + employee_id + '"] td[mngr-dscn="F"]').html('<span>N</span>&nbsp;&nbsp;<a class="tbold_uline" style="color: blue;">[지정]</a>');
							}
							useCnt++;
						} else if(status==2) {
							$("#stopUserList").append('<tr user_id="' + employee_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                '<td class="cn">' + company_name + '</td>' +
	                                '<td class="nm">' + employee_name + '</td>' +
	                                '<td class="dv">' + department_name + '</td>'+
	                                '<td class="jb">' + job_title + '</td>' +
	                                '<td class="em">' + employee_id + '</td>'+
	                                '<td class="hp">' + phone + '</td>'+
	                                '<td>' + join_date + '</td>'+
	                                "<td>"+""+"</td>"+
	                                "<td>"+""+"</td>"+
	                                "<td>"+""+"</td>"+
	                                '<td>2&nbsp;<a class="tbold_uline">[보기]</a></td>'+
	                                '<td stts="N">이용중지&nbsp;<a class="tbold_uline">[해제]</a></td>'+
	                                '<td></td>'+
	                                '<td><a class="tbold_uline" style="color: red">삭제</a></td>'+
	                                "</tr>");
							stopCnt++;
						} else {
							$("#joinUserList").append(
									'<tr user_id="' + employee_id + '">' +
										'<td>' + employee_name + '</td>' +
										'<td>' + employee_id + '</td>' +
										'<td>' + join_date + '</td>' +
										'<td style="font-weight: bold;">' +
											'<a id="accept" class="tbold_uline" style="color: blue">[승인]</a>&nbsp;&nbsp;<a id="deny" style="color: red" class="tbold_uline">[거절]</a>' +
										'</td>' +
	                                "</tr>");
							joinCnt++;
						}
	                }
	                
	                $('#normalUserList td').each(function() {
					    if ($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
	                $('#stopUserList td').each(function() {
					    if ($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
	                $('#joinUserList td').each(function() {
					    if ($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
	                
	                if($("#normalUserList").children().length === 0) {
	                	$("#normalUserList").append("<tr><td colspan='14'>결과값이 존재하지 않습니다.</td></tr>");
	                }
	                
	                if($("#stopUserList").children().length === 0) {
	                	$("#stopUserList").append("<tr><td colspan='14'>결과값이 존재하지 않습니다.</td></tr>");
	                }
	                
	                if($("#joinUserList").children().length === 0) {
	                	$("#joinUserList").append("<tr><td colspan='4'>결과값이 존재하지 않습니다.</td></tr>");
	                }
	                
	                
	                
	                $("#useCnt").text(useCnt);
	                $("#stopCnt").text(stopCnt);
	                $("#joinCnt").text(joinCnt);

	            }
	        })
		}
		
		
		function project_information_load(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 13,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
	                	let project_name = json[i].project_name;
	                	let permission_write = json[i].permission_write;
	                	let permission_reply = json[i].permission_reply;
	                	let permission_view = json[i].permission_view;
	                	let permission_file = json[i].permission_file;
	                	let permission_modify = json[i].permission_modify;

	                	let project_member_count = json[i].project_member_count;
						
//						alert(project_member_count);
						$("input[name='proj_name']").attr("project_id", project_id);
	                	$("input[name='proj_name']").val(project_name);
	                	if(permission_write==0) {
	                		$("#prj_mngr_wr_yn_area input[name='prj_mngr_wr_yn'][value='N']").prop("checked", true);
	                	} else if(permission_write==1) {
	                		$("#prj_mngr_wr_yn_area input[name='prj_mngr_wr_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_reply==0) {
	                		$("#prj_mngr_wr_cm_yn_area input[name='prj_mngr_wr_cm_yn'][value='N']").prop("checked", true);
	                	} else if(permission_reply==1) {
	                		$("#prj_mngr_wr_cm_yn_area input[name='prj_mngr_wr_cm_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_view==0) {
	                		$("input[name='omprj_srch_auth_yn'][value='N']").prop("checked", true);
	                	} else if(permission_view==1) {
	                		$("input[name='omprj_srch_auth_yn'][value='Y']").prop("checked", true);
	                	}
		      	    	
						if(permission_file==0) {
	                		$("input[name='omprj_prj_auth'][value='N']").prop("checked", true);
	                	} else if(permission_file==1) {
	                		$("input[name='omprj_prj_auth'][value='Y']").prop("checked", true);
	                	}
					
						if(permission_modify==0) {
	                		$("input[name='riteEditAuth'][value='MNGRMYSELF']").prop("checked", true);
	                	} else if(permission_modify==1) {
	                		$("input[name='riteEditAuth'][value='MYSELF']").prop("checked", true);
	                	}
						
						$("#addProjLayer2 input[name='employee_name']").css("display", "none");
						$("#mngrAdd2").css("display", "none");
						
	                }
	            }
	        })
		}
		
		
		function project_information_load_member(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 14,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
 	                $("#mngr_tbody2").html("");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
						employee_id = json[i].employee_id;
						let employee_name = json[i].employee_name;
						let department_name = json[i].department_name;
						let job_title = json[i].job_title;
						let join_date = json[i].join_date;
						let phone = json[i].phone;
						let project_admin = json[i].project_admin;
						
						
						if(project_admin==1) {
							$("#mngr_tbody2").append('<tr>'+
		                                "<td>"+employee_name+"</td>"+
		                                "<td>"+'<span class="user_ids">' + employee_id + '</span>'+"</td>"+
		                                "<td>"+department_name+"</td>"+
		                                "<td>"+job_title+"</td>"+
		                                "<td>"+join_date+"</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-release" value="destory">관리자[해제]</a>'+"</td>"+
		                                "</tr>");
						} else {
							$("#mngr_tbody2").append('<tr>'+
		                                "<td>"+employee_name+"</td>"+
		                                "<td>"+'<span class="user_ids">' + employee_id + '</span>'+"</td>"+
		                                "<td>"+department_name+"</td>"+
		                                "<td>"+job_title+"</td>"+
		                                "<td>"+join_date+"</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-selecte" value="select">정상[선택]</a>'+"</td>"+
		                                "</tr>");
						}
						
						$('#mngr_tbody2 td').each(function() {
						    if ($(this).text().trim() === 'null') {
						      $(this).text('');
						    }
						});
						
	                }
	            }
	        })
		}
		
		
		
		function company_project_manage_load() {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 2,
	            	send_company_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
 	                $("#comm_proj_tbody").html("");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
		
						let project_id = json[i].project_id;
						let project_name = json[i].project_name;
						let project_birthday = json[i].project_birthday;
						let recent_date = json[i].recent_date;
						let board_count = json[i].board_count;
						let reply_count = json[i].reply_count;
						let register_id = json[i].register_id;
						
						
						$("#comm_proj_tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">' + 
													 '<td>' + recent_date + '</td>' + 
													 '<td>' + project_birthday + '</td>' + 
													 '<td style="text-align: left; padding-left: 10px;">' + project_name + '</td>' + 
													 '<td>' + board_count + '</td>' + 
													 '<td>' + reply_count + '</td>' + 
													 '<td>' + register_id + '</td>' + 
													 '</tr>');
	                }
					$('#comm_proj_tbody td').each(function() {
					    if ($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
					
					if(i==0) {
						$("#comm_proj_tbody").append('<tr><td colspan="7">결과값이 존재하지 않습니다.</td></tr>');
					}
	            }
	        })
		}
		
		
		function company_project_information_load(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 13,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
						$("#회사_프로젝트_정보_수정 input[name='proj_name']").attr("project_id", project_id);
						
	                	let project_name = json[i].project_name;
	                	let permission_write = json[i].permission_write;
	                	let permission_reply = json[i].permission_reply;
	                	let permission_view = json[i].permission_view;
	                	let permission_file = json[i].permission_file;
	                	let permission_modify = json[i].permission_modify;

	                	let project_member_count = json[i].project_member_count;
						
//						alert(project_member_count);
	                	
	                	$("#회사_프로젝트_정보_수정 input[name='proj_name']").val(project_name);
	                	if(permission_write==0) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_yn'][value='N']").prop("checked", true);
	                	} else if(permission_write==1) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_reply==0) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_cm_yn'][value='N']").prop("checked", true);
	                	} else if(permission_reply==1) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_cm_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_view==0) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_srch_auth_yn'][value='N']").prop("checked", true);
	                	} else if(permission_view==1) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_srch_auth_yn'][value='Y']").prop("checked", true);
	                	}
		      	    	
						if(permission_file==0) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_prj_auth'][value='N']").prop("checked", true);
	                	} else if(permission_file==1) {
	                		$("#회사_프로젝트_정보_수정 input[name='mprj_prj_auth'][value='Y']").prop("checked", true);
	                	}
					
						if(permission_modify==0) {
	                		$("#회사_프로젝트_정보_수정 input[name='iteEditAuth'][value='MNGRMYSELF']").prop("checked", true);
	                	} else if(permission_modify==1) {
	                		$("#회사_프로젝트_정보_수정 input[name='iteEditAuth'][value='MYSELF']").prop("checked", true);
	                	}
						
						$("#addProjLayer2 input[name='employee_name']").css("display", "none");
						$("#mngrAdd2").css("display", "none");
						
	                }
	            }
	        })
		}
		
		function company_project_information_load_member(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 14,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
 	                $("#mngr_tbody_2").html("");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
						employee_id = json[i].employee_id;
						let employee_name = json[i].employee_name;
						let department_name = json[i].department_name;
						let job_title = json[i].job_title;
						let join_date = json[i].join_date;
						let phone = json[i].phone;
						let project_admin = json[i].project_admin;
						
						
						if(project_admin==1) {
							$("#mngr_tbody_2").append('<tr>'+
		                                "<td>"+employee_name+"</td>"+
		                                "<td>" + job_title + "</td>"+
		                                "<td>"+department_name+"</td>"+
		                                "<td>"+'<span class="user_ids">' + employee_id+ '</span>' + "</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-release" value="destory">관리자[해제]</a>'+"</td>"+
		                                "</tr>");
						} else {
							$("#mngr_tbody_2").append('<tr>'+
		                            	"<td>"+employee_name+"</td>"+
		                                "<td>" + job_title + "</td>"+
		                                "<td>"+department_name+"</td>"+
		                                 "<td>"+'<span class="user_ids">' + employee_id+ '</span>' + "</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-selecte" value="select">정상[선택]</a>'+"</td>"+
		                                "</tr>");
						}
						
						$('#mngr_tbody_2 td').each(function() {
						    if ($(this).text().trim() === 'null') {
						      $(this).text('');
						    }
						});
						
	                }
	            }
	        })
		}
		
		
		function open_project_manage_load() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 20,
	            	send_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
					$("#open_proj_tbody").html("");
	                for (var i = 0; i < json.length; i++) {
	                	let project_id = json[i].project_id;
	                	let category = json[i].category;
	                	let project_name = json[i].project_name;
	                	let project_member_count = json[i].project_member_count;
	                	let board_count = json[i].board_count;
	                	let reply_count = json[i].reply_count;
	                	let recent_date = json[i].recent_date;
	                	let project_birthday = json[i].project_birthday;
						
						$("#open_proj_tbody").append('<tr project_id="' + project_id + '">' + 
														'<td>' + category + '</td>' + 
														'<td style="text-align: left; padding-left: 10px;">' + project_name + '</td>' + 
														'<td>' + project_member_count + '</td>' + 
														'<td>' + board_count + '</td>' + 
														'<td>' + reply_count + '</td>' + 
														'<td>' + recent_date + '</td>' + 
														'<td>' + project_birthday + '</td>' + 
													'</tr>');
						
					}
	            }
	        })
		}
		
		function open_project_information_load(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 13,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
// 	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
						$("#projEditPopUp input[name='open_proj_name']").attr("project_id", project_id);
						
	                	let project_name = json[i].project_name;
	                	let permission_write = json[i].permission_write;
	                	let permission_reply = json[i].permission_reply;
	                	let permission_view = json[i].permission_view;
	                	let permission_file = json[i].permission_file;
	                	let permission_modify = json[i].permission_modify;


						
	                	
	                	$("#projEditPopUp input[name='open_proj_name']").val(project_name);
	                	if(permission_write==0) {
	                		$("#projEditPopUp input[name='openmngr_wr_yn'][value='N']").prop("checked", true);
	                	} else if(permission_write==1) {
	                		$("#projEditPopUp input[name='openmngr_wr_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_reply==0) {
	                		$("#projEditPopUp input[name='openmngr_wr_cm_yn'][value='N']").prop("checked", true);
	                	} else if(permission_reply==1) {
	                		$("#projEditPopUp input[name='openmngr_wr_cm_yn'][value='Y']").prop("checked", true);
	                	}
	                	
	                	if(permission_view==0) {
	                		$("#projEditPopUp input[name='srch_auth_yn'][value='N']").prop("checked", true);
	                	} else if(permission_view==1) {
	                		$("#projEditPopUp input[name='srch_auth_yn'][value='Y']").prop("checked", true);
	                	}
		      	    	
						if(permission_file==0) {
	                		$("#projEditPopUp input[name='prj_auth'][value='N']").prop("checked", true);
	                	} else if(permission_file==1) {
	                		$("#projEditPopUp input[name='prj_auth'][value='Y']").prop("checked", true);
	                	}
					
						if(permission_modify==0) {
	                		$("#projEditPopUp input[name='writeEditAuth'][value='MNGRMYSELF']").prop("checked", true);
	                	} else if(permission_modify==1) {
	                		$("#projEditPopUp input[name='writeEditAuth'][value='MYSELF']").prop("checked", true);
	                	}
						
						
	                }
	            }
	        })
		}
		
		function open_project_information_load_member(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 14,
	            	send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = JSON.parse(data.trim());	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
 	                $("#mngr_tbody3").html("");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
						employee_id = json[i].employee_id;
						let employee_name = json[i].employee_name;
						let department_name = json[i].department_name;
						let job_title = json[i].job_title;
						let join_date = json[i].join_date;
						let phone = json[i].phone;
						let project_admin = json[i].project_admin;
						
						
						if(project_admin==1) {
							$("#mngr_tbody3").append('<tr>'+
		                                "<td>"+employee_name+"</td>"+
		                                "<td>" + job_title + "</td>"+
		                                "<td>"+department_name+"</td>"+
		                                "<td>"+'<span class="user_ids">' + employee_id+ '</span>' + "</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-release" value="destory">관리자[해제]</a>'+"</td>"+
		                                "</tr>");
						} else {
							$("#mngr_tbody3").append('<tr>'+
		                            	"<td>"+employee_name+"</td>"+
		                                "<td>" + job_title + "</td>"+
		                                "<td>"+department_name+"</td>"+
		                                 "<td>"+'<span class="user_ids">' + employee_id+ '</span>' + "</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'<a class="out_bt tbold_uline admin-selecte" value="select">정상[선택]</a>'+"</td>"+
		                                "</tr>");
						}
						
						$('#mngr_tbody3 td').each(function() {
						    if ($(this).text().trim() === 'null') {
						      $(this).text('');
						    }
						});
						
	                }
	            }
	        })
		}
		
		
		function open_project_information_load_category(project_id) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
            	type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 6,
	            	send_company_id: company_id,
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					$("#openProjectCategory").html("");
	                console.log(data);
					var json = data;
	                for (var i = 0; i < json.length; i++) {
						let category_id = json[i].category_id;
						let category = json[i].category;
						$("#openProjectCategory").append('<option value="' + i + '" category_id="' + category_id + '">' + category + '</option>');
						let project_category = $("#open_proj_tbody tr[project_id='" + project_id + "'] td:first-child").text();
						if(project_category == category) {
							$("#openProjectCategory option[category_id='" + category_id + "']").attr("selected", true);
						}
	                }
	            }
	        })
		}
		
		
		function my_load() {
		$.ajax({
            url: "withServlet",		// 데이터를 가져올 경로 설정
            type: "POST",		// 데이터를 가져오는 방식
            data: {
            	send_number: 0,
            	send_my_id: my_id
            	},
            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
                console.log(data);
                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
                	
 					let employee_name = json.employee_name;
 					let job_title = json.job_title;
					let department_name = json.department_name;
					let phone = json.phone;
	      	    	$("#mngr_tbody_2").append('<tr>'+
		                                "<td>"+employee_name+"</td>"+
		                                "<td>"+'<span class="user_ids">' + job_title + '</span>'+"</td>"+
		                                "<td>"+department_name+"</td>"+
		                                "<td>"+my_id+"</td>"+
		                                "<td>"+phone+"</td>"+
		                                "<td>"+'Y'+"</td>"+
		                                "</tr>");
                
            }
        })
		}



		function category_load() {
		$.ajax({
            url: "withServlet",		// 데이터를 가져올 경로 설정
            type: "POST",		// 데이터를 가져오는 방식
            data: {
            	send_number: 4,
            	send_company_id: company_id
            	},
            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
				$("#open_catg_tbody").html("");
                console.log(data);
                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
                	
 				for(var i=0; i < json.length; i++) {
					let category_id = json[i].category_id;
					let category = json[i].category;
					let status = json[i].status;
					let project_count = json[i].project_count;
					if(status==1) {
						$("#open_catg_tbody").append('<tr category_id="' + category_id + '" style="">' + 
													'<td class="drag_bt">' + 
													'</td>' + 
													'<td class="catg_td">' + category + '</td>' + 
													'<td><span style="margin-left:15px">' + project_count + '</span></td>' + 
													'<td class="use_yn" data-use-yn="Y">활성</td>' + 
													'<td><span style="display: none; cursor: pointer; color: red; margin-left: 15px; margin-right: 15px;" class="delete_bt btn btn_style1">삭제</span></td>' + 
												'</tr>');
					} else {
						$("#open_catg_tbody").append('<tr category_id="' + category_id + '" style="">' + 
													'<td class="drag_bt">' + 
													'</td>' + 
													'<td class="catg_td">' + category + '</td>' + 
													'<td><span style="margin-left:15px">' + project_count + '</span></td>' + 
													'<td class="use_yn" data-use-yn="Y">비활성</td>' + 
													'<td><span style="display: none; cursor: pointer; color: red; margin-left: 15px; margin-right: 15px;" class="delete_bt btn btn_style1">삭제</span></td>' + 
												'</tr>');
					}
				}
                
            }
        })


		}
	

		function department_load() {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 8,
	            	send_company_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					$("#orgChartTree .tui-tree.tui-tree-root").html("");
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                	
	 				for(var i=0; i < json.length; i++) {
						let department_id = json[i].department_id;
						let department_name = json[i].department_name;
						let up_department_id = json[i].up_department_id;
						let exposure_procedure = json[i].exposure_procedure;
						
						if(exposure_procedure == 1) {
							$("#orgChartTree .tui-tree.tui-tree-root").append(
									"			<li department_id='"+department_id+"' exposure_procedure='" + exposure_procedure + "' class='tui-tree-node tui-tree-leaf'> " +
									"	        	<div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
									"	            	<span class='tui-tree-text tui-js-tree-text'>"+department_name+"</span> " +
									"	        	</div> " +
									"	    	</li> ");
						} else {
							let hasUl = $("#orgChartTree .tui-tree.tui-tree-root").find("li[department_id='" + up_department_id + "']").children("ul").length;
							if(hasUl>=1) {
								$("#orgChartTree .tui-tree.tui-tree-root").find("li[department_id='" + up_department_id + "']").children("ul").append(
									"			<li department_id='"+department_id+"' exposure_procedure='" + exposure_procedure + "' class='tui-tree-node tui-tree-leaf'> " +
									"	        	<div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
									"	            	<span class='tui-tree-text tui-js-tree-text'>"+department_name+"</span> " +
									"	        	</div> " +
									"	    	</li> "
								);
							} else if(hasUl==0) {
								$("#orgChartTree .tui-tree.tui-tree-root").find("li[department_id='" + up_department_id + "']").removeClass("tui-tree-leaf");
								$("li[department_id='" + up_department_id + "']").append('<ul class="tui-tree-subtree tui-js-tree-subtree">'+
																						 	"			<li department_id='"+department_id+"' exposure_procedure='" + exposure_procedure + "' class='tui-tree-node tui-tree-leaf'> " +
																							"	        	<div class='tui-tree-content-wrapper' style='padding-left: 23px'> " +
																							"	            	<span class='tui-tree-text tui-js-tree-text'>"+department_name+"</span> " +
																							"	        	</div> " +
																							"	    	</li> " +
																						 '</ul>');
							}
						}
								
						
						
						
						
					}
					$(".tui-tree-node").each(function() {
				    var parents = $(this).parents('.tui-tree-node');
					var pad = (parents.length)*23+23;
				    $(this).children("div").css("padding-left",pad+"px");
				    console.log("부모 개수: " + parents.length);
				  });
				
				
				  // 페이지 로드 시 초기 상태를 판단하여 버튼 생성 또는 제거
				  $(".tui-tree-node").each(function() {
				    if ($(this).find(".tui-tree-subtree").length > 0 && $(this).children("div").find(".tui-tree-toggle-btn").length === 0) {
				      $(this).children("div").prepend(
				    		  "		<button type='button' class='tui-tree-toggle-btn tui-js-tree-toggle-btn'> " + 
						    	"		<span class='tui-ico-tree'></span> " +
						        "        </button> "
				      );
				    } else if ($(this).find(".tui-tree-subtree").length === 0) {
				      $(this).children("div").find(".tui-tree-toggle-btn").remove();
				    }
				    
				    if($(this).find(".tui-tree-subtree").length>0){
				    	$(this).addClass("tui-tree-opened");
				    }
				  });
	                
	            } // sucees
	        });
	
	
		}
		
		function project_search(search_name, start_date, end_date) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 13,
					send_company_id: company_id,
	            	send_search_name: search_name,
					send_start_date: start_date,
					send_end_date: end_date
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                	
	 				$("#useStatPrjScroll tbody").html("");
					let i = 0;
	                for (i = 0; i < json.length; i++) {
	                	let project_name = json[i].project_name;
	                	project_id = json[i].project_id;
	                	let recent_date = json[i].recent_date;
	                	let project_birthday = json[i].project_birthday;
	                	let project_member_count = json[i].project_member_count;
	                	let project_admin_count = json[i].project_admin_count;
	                	let project_admin_name_1 = null;
	                	if(project_admin_count>=1) {
	                		project_admin_name_1 = json[i].project_admin_name;
	                	}
	                	let board_count = json[i].board_count;
	                	let reply_count = json[i].reply_count;
	                	let chat_count = json[i].chat_count;
	                	let schedule_count = json[i].schedule_count;
	                	let work_count = json[i].work_count;
	                	
	                	if(project_admin_count>=2) {
	                		let project_admin_count_ = project_admin_count-1;
	                		let employees = project_member_count - project_admin_count;
	                		$("#useStatPrjScroll tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                "<td>"+project_name+"</td>"+
	                                "<td>"+project_admin_name_1+"외 " + project_admin_count_ + "명</td>"+
	                                "<td>"+project_member_count+"</td>"+
	                                "<td>"+employees+"</td>"+
	                                "<td>"+board_count+"</td>"+
	                                "<td>"+reply_count+"</td>"+
	                                "<td>"+chat_count+"</td>"+
	                                "<td>"+schedule_count+"</td>"+
	                                "<td>"+work_count+"</td>"+
	                                "<td>"+recent_date+"</td>"+
	                                "<td>"+project_birthday+"</td>"+
	                                "</tr>");
	                	} else {
	                		let employees = project_member_count - project_admin_count;
		                	$("#useStatPrjScroll tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">'+		// append: 셀렉터 안에 요소를 추가
	                                "<td>"+project_name+"</td>"+
	                                "<td>"+project_admin_name_1+"</td>"+
	                                "<td>"+project_member_count+"</td>"+
	                                "<td>"+employees+"</td>"+
	                                "<td>"+board_count+"</td>"+
	                                "<td>"+reply_count+"</td>"+
	                                "<td>"+chat_count+"</td>"+
	                                "<td>"+schedule_count+"</td>"+
	                                "<td>"+work_count+"</td>"+
	                                "<td>"+recent_date+"</td>"+
	                                "<td>"+project_birthday+"</td>"+
	                                "</tr>");
	                	}
	                }
	                
	                $('#useStatPrjScroll td').each(function() {
					    if($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
	                
	                if(i==0) {
                		$("#useStatPrjScroll tbody").append('<tr style="cursor: pointer; background-color: rgb(255, 255, 255);">'+
                				"<td  colspan='11'>"+"결과값이 존재하지 않습니다."+"</td>"+
                				"</tr>");
                	}
	                
	            }
	        });


		}
		
		
		function company_project_search(search_name) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 14,
					send_company_id: company_id,
					send_search_name: search_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                $("#comm_proj_tbody").html("");                                    	// trim()을 통해 불필요한 여백 제거
	                for (var i = 0; i < json.length; i++) {
		
						let project_id = json[i].project_id;
						let project_name = json[i].project_name;
						let project_birthday = json[i].project_birthday;
						let recent_date = json[i].recent_date;
						let board_count = json[i].board_count;
						let reply_count = json[i].reply_count;
						let register_id = json[i].register_id;
						
						
						$("#comm_proj_tbody").append('<tr project_id="' + project_id + '" style="cursor: pointer; background-color: rgb(255, 255, 255);">' + 
													 '<td>' + recent_date + '</td>' + 
													 '<td>' + project_birthday + '</td>' + 
													 '<td style="text-align: left; padding-left: 10px;">' + project_name + '</td>' + 
													 '<td>' + board_count + '</td>' + 
													 '<td>' + reply_count + '</td>' + 
													 '<td>' + register_id + '</td>' + 
													 '</tr>');
	                }
					$('#comm_proj_tbody td').each(function() {
					    if ($(this).text().trim() === 'null') {
					      $(this).text('');
					    }
					});
					
					if(i==0) {
						$("#comm_proj_tbody").append('<tr><td colspan="7">결과값이 존재하지 않습니다.</td></tr>');
					}
	 				
	            }
	        });


		}
		
		
		
		function open_project_search(search_name) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 15,
					send_company_id: company_id,
					send_search_name: search_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                $("#open_proj_tbody").html("");
	                for (var i = 0; i < json.length; i++) {
	                	let project_id = json[i].project_id;
	                	let category = json[i].category;
	                	let project_name = json[i].project_name;
	                	let project_member_count = json[i].member_count;
	                	let board_count = json[i].board_count;
	                	let reply_count = json[i].reply_count;
	                	let recent_date = json[i].recent_date;
	                	let project_birthday = json[i].project_birthday;
						
						$("#open_proj_tbody").append('<tr project_id="' + project_id + '">' + 
														'<td>' + category + '</td>' + 
														'<td style="text-align: left; padding-left: 10px;">' + project_name + '</td>' + 
														'<td>' + project_member_count + '</td>' + 
														'<td>' + board_count + '</td>' + 
														'<td>' + reply_count + '</td>' + 
														'<td>' + recent_date + '</td>' + 
														'<td>' + project_birthday + '</td>' + 
													'</tr>');
						
					}
	 				
	            }
	        });


		}
		
		
		function usage_statistics_search(search_name) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 17,
					send_company_id: company_id,
					send_search_name: search_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                $("#userScrollContentWrap tbody").html("");
	                for (var i = 0; i < json.length; i++) {
	                	let company_name = json[i].company_name;
	                	let employee_name = json[i].employee_name;
	                	let department_name = json[i].department_name;
	                	let job_title = json[i].job_title;
	                	let employee_id = json[i].employee_id;
	                	let project_count = json[i].project_count;
	                	let board_count = json[i].board_count;
	                	let reply_count = json[i].reply_count;
	                	let chatRoom_count = json[i].chatRoom_count;
	                	let chating_count = json[i].chating_count;
	                	
						
						$("#userScrollContentWrap tbody").append('<tr>' + 
							'<td>' + company_name + '</td>' + 
							'<td>' + employee_name + '</td>' + 
							'<td>' + department_name + '</td>' + 
							'<td>' + job_title + '</td>' + 
							'<td>' + employee_id + '</td>' + 
							'<td class="active-project-num">' + project_count + '</td>' + 
							'<td>' + board_count + '</td>' + 
							'<td>' + reply_count + '</td>' + 
							'<td>' + chatRoom_count + '</td>' + 
							'<td>' + chating_count + '</td>' + 
							'</tr>');
					}
					
					$("#userScrollContentWrap tbody tr td").each(function() {
						if($(this).text() == "undefined") {
							$(this).text("");
						}
					})
	 				
	            }
	        });


		}
		
		
		function admin_log_load(search_name, start_date, end_date, search_gubun) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 18,
					send_company_id: company_id,
					send_search_name: search_name,
					send_start_date: start_date,
					send_end_date: end_date,
					send_search_gubun: search_gubun
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                console.log(data);
	                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
	//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
	                $("#editLogScrollContentWrap tbody").html("");
	                for (var i = 0; i < json.length; i++) {
	                	let employee_id = json[i].employee_id;
	                	let employee_name = json[i].employee_name;
	                	let change_menu = json[i].change_menu;
	                	let functions = json[i].function;
	                	let object = json[i].object;
	                	let changes = json[i].changes;
	                	let changes_date = json[i].changes_date;
						
	                	
						
						$("#editLogScrollContentWrap tbody").append('<tr>' + 
							'<td>' + employee_name + "(" + employee_id + ")" + '</td>' + 
							'<td>' + change_menu + '</td>' + 
							'<td>' + functions + '</td>' + 
							'<td>' + object + '</td>' + 
							'<td>' + changes + '</td>' + 
							'<td style="width: 110px;">' + changes_date + '</td>' + 
							'</tr>');
					}
					
					$("#editLogScrollContentWrap tbody tr td").each(function() {
						if($(this).text() == "undefined") {
							$(this).text("");
						}
					})
	 				
	            }
	        });


		}
		
		
		function employee_name_load(employee_id, callback) {
		    $.ajax({
		        url: "withServlet",
		        type: "POST",
		        data: {
		            send_number: 20,
		            send_employee_id: employee_id
		        },
		        success: function(data) {
		            callback(data.employee_name);
		        },
		        error: function(xhr, status, error) {
		            console.log("AJAX request failed:", error);
		        }
		    });
		}
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		function company_name_correction() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 3,
	            	send_id: company_id,
	            	send_company_name: $("#comm input").val()
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                admin_log_add("회사명 변경", "", "'" + defalut_name + "' → '" + $("#comm input").val() + "'");
	            }
	        })
		}
		
		
		function company_img_correction() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 4,
	            	send_id: company_id,
	            	send_company_img: file_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                admin_log_add("로고 설정", "", "로고 등록");
	            }
	        })
		}
		
		
		function company_url_correction() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 5,
	            	send_id: company_id,
	            	send_company_url: $("#domain input").val()
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                admin_log_add("전용 URL", "", "'" + defalut_name + "' → '" + $("#domain input").val() + "'");
	            }
	        })
		}
		
		function company_join_option_correction() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 6,
	            	send_id: company_id,
	            	send_company_join_option: $("#comm_domain input").val()
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
//	                admin_log_add("직원 참여 옵션 변경", "", "'" + defalut_name + "' → '" + $("#domain input").val() + "'");
	            }
	        })
		}
		
		function employee_status_correction_2() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 8,
	            	send_employee_id: employee_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
					    admin_log_add("상태 변경(이용중지)", e_name, "");
					});
	            }
	        })
		}
		
		function employee_status_correction_1() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 9,
	            	send_employee_id: employee_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	                let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						if($("#USER_STOP").hasClass("on")) {
					    	admin_log_add("상태 변경(이용중지 해제)", e_name, "");
						} else {
							admin_log_add("가입 승인", e_name, "");
						}
					});
	            }
	        })
		}
		
		function employee_delete() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 10,
	            	send_employee_id: employee_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						admin_log_add("구성원 삭제", e_name, "");
					});
	            }
	        })
		}
		
		function employee_company_admin_0() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 11,
	            	send_employee_id: employee_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						admin_log_add("관리자 해제", e_name, "");
					});
	            }
	        })
		}
		
		function employee_company_admin_1() {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 12,
	            	send_employee_id: employee_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						admin_log_add("관리자 지정", e_name, "");
					});
	            }
	        })
		}
		
		function project_information_admin_correction_1(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 15,
	            	send_employee_id: employee_id,
					send_project_id:project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						let project_name = 
						admin_log_add("프로젝트 관리자 지정", p_name + "(" + project_id + ")", e_name);
					});
	            }
	        })
		}
		
		function project_information_admin_correction_0(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 16,
	            	send_employee_id: employee_id,
					send_project_id: project_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					let e_id = employee_id;
					employee_name_load(employee_id, function(employee_name) {
						let e_name = employee_name + "(" + e_id + ")";
						admin_log_add("프로젝트 관리자 해제", p_name + "(" + project_id + ")", e_name);
					});
	            }
	        })
		}
		
		
		function project_information_correction(project_id, num1, num2, num3, num4, num5, project_name) {
//			alert(project_id);
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 17,
	            	send_project_id: project_id,
					send_num1: num1,
					send_num2: num2,
					send_num3: num3,
					send_num4: num4,
					send_num5: num5,
					send_project_name: project_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("프로젝트 설정 변경", p_name + "(" + project_id + ")", "");
	            }
	        })
		}
		
		function project_information_correction_category(project_id, category_id) {
//			alert(project_id);
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 7,
	            	send_project_id: project_id,
					send_category_id: category_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	            }
	        })
		}
		
		function project_delete(project_id) {
			$.ajax({
	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
	            	send_number: 18,
	            	send_project_id: project_id,
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("프로젝트 삭제", p_name + "(" + project_id + ")", "");
	            }
	        })
		}
		
//		function project_category_add() {
//			$.ajax({
//	            url: "어드민_회사정보_DB.jsp",		// 데이터를 가져올 경로 설정
//	            type: "POST",		// 데이터를 가져오는 방식
//	            data: {
//	            	send_number: 20,
//	            	send_project_category_name: ,
//	            	},
//	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
//	            }
//	        })
//		}
		
		function company_project_create(num1, num2, num3, num4, num5, project_name) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 3,
					send_num1: num1,
					send_num2: num2,
					send_num3: num3,
					send_num4: num4,
					send_num5: num5,
					send_project_name: project_name,
					send_employee_id: my_id, 
					send_company_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("회사 프로젝트 생성", project_name + "(" + data.project_id + ")", "");
	            }
	        })
		}
		
		function category_correction(category_id, category, status, delete_, add) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 5,
					send_category_id: category_id,
					send_category: category,
					send_status: status,
					send_delete: delete_,
					send_add: add,
					send_company_id: company_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	            }
	        })
		}
		
//		function category_add(category, status) {
//			$.ajax({
//	            url: "/webproject1/withServlet",		// 데이터를 가져올 경로 설정
//	            type: "POST",		// 데이터를 가져오는 방식
//	            data: {
//					send_number: 6,
//					send_category: category,
//					send_status: status,
//					send_company_id: company_id
//	            	},
//	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
//	            }
//	        })
//		}


		function department_add(department_name, up_department_id, exposure_procedure) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 9,
					send_company_id: company_id,
					send_department_name: department_name,
					send_up_department_id: up_department_id,
					send_exposure_procedure: exposure_procedure
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("부서 등록", department_name, "");
	            }
	        })
		}
		
		function department_delete(department_id, department_name) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 10,
					send_department_id: department_id
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("부서 삭제", department_name + "(" + department_id + ")", "");
	            }
	        })
		}
		
		function company_use_department(use_department) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 11,
					send_company_id: company_id,
					send_use_department: use_department
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					if(use_department==1) {
						admin_log_add("조직도 활성화", "", "");
					} else if(use_department==0) {
						admin_log_add("조직도 비활성화", "", "");
					}
	            }
	        });
		}
		
		function department_correction(department_id, department_name, tex) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 12,
					send_department_id: department_id,
					send_department_name: department_name
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
					admin_log_add("부서 수정", department_name + "(" + department_id + ")", "'" + tex + "'→'" + department_name + "'");
	            }
	        });
		}
		
		
		function admin_log_add(functions, object, changes) {
			$.ajax({
	            url: "withServlet",		// 데이터를 가져올 경로 설정
	            type: "POST",		// 데이터를 가져오는 방식
	            data: {
					send_number: 19,
					send_company_id: company_id,
					send_employee_id: my_id,
					send_change_menu: $(".with-admin-menu.on").text(),
					send_function: functions,
					send_object: object,
					send_changes: changes
	            	},
	            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
	            }
	        });
		}
		
		
		
	
	
	
		$(function() {
			
		  company_information_load();
//       	  alert("aebaeb" + company_id);
      	  
		  
		
			
		
			
			
			
	      $(".with-admin-menu").click( function() {
	    	 company_information_load();
	    	 project_manage_load();
	    	 employees_manage_load();
			 employee_invite();
			 company_project_manage_load();
			 open_project_manage_load();
			 category_load();
			 department_load();
			 usage_statistics_search("");
			 admin_log_load("", "2001-01-01", "2099-12-31", "1");
			 $("#addProjLayer2").css("display", "none");
			 $("#addProjLayer").css("display", "none");
			 $("#projEditPopUp").css("display", "none");
	    	 let title = $(this).text().replace(/\s+/g, "_");
 	    	 $(".left_menu").css("display", "none");
 	    	 $("#" + title).css("display", "inline");
 	    	 $(".with-admin-menu").removeClass( 'on' );
 	    	 $(this).addClass('on');
	      });
	      
	      
	      $("#USER_USE").click(function() {
	    	  $(this).parent().find(".on").addClass("off");
	    	  $(this).parent().find(".on").removeClass("on");
	    	  $(this).removeClass("off");
	    	  $(this).addClass("on");
	    	  $("#구성원_관리 .list_table.mgt10.mgb15").css("display", "none");
	    	  $("#USER-USE-TABLE").css("display", "block");
	      });
	      
		  $("#USER_STOP").click(function() {
			  $(this).parent().find(".on").addClass("off");
			  $(this).parent().find(".on").removeClass("on");
			  $(this).removeClass("off");
			  $(this).addClass("on");
			  $("#구성원_관리 .list_table.mgt10.mgb15").css("display", "none");
			  $("#USER-STOP-TABLE").css("display", "block");
	      });
		  
		  $("#USER_WAIT").click(function() {
			  $(this).parent().find(".on").addClass("off");
			  $(this).parent().find(".on").removeClass("on");
			  $(this).removeClass("off");
			  $(this).addClass("on");
			  $("#구성원_관리 .list_table.mgt10.mgb15").css("display", "none");
			  $("#USER-WAIT-TABLE").css("display", "block");
	      });
		  
		  $(".list_table.mgt10.mgb15 th").click(function() {
		      let check =  $(this).find("div").find("a").hasClass("sort");
		      if(check) {
		    	  $(this).parent().find("a").removeClass("sort_r").addClass("sort");
		    	  $(this).find("div").find("a").removeClass("sort").addClass("sort_r");
		      } else {
		    	  $(this).find("div").find("a").removeClass("sort_r").addClass("sort");
		      }
		  });
		  
		  $("#tableSearchArea a.btn.srchbtn_style").click(function () {
			  let search = $("#SRCH_WORD").val();
			  
			  $(".list_table.mgt10.mgb15").each(function(index, item) {
			      if($(this).css("display") == "block") {
				      let selectedText = $("#user_gubun_select option:selected").text();
				      let tr = "";
				      if(selectedText=="이름") {
				    	  $(".nm").each(function(index, item) {
				    		  let find = $(this).text();
				    		  if(find.includes(search)) {
 				    			  let id = $(this).parent().attr("user-id");
				    			  tr = tr + $(this).parent()[0].outerHTML + "\n";
				    			  
				    		  }
				    	  });
				      }
				      console.log(tr);
				      $("#normalUserList").html(tr);
				      if($("#SRCH_WORD").val()=="") {
				    	  employees_manage_load();
				      }
				      return false;
				  }
			  });
			  
		  });
			  
	      $("#addUserBtn").click(function() {
	    	  if($("#newAddUserBtnArea").css("display")=="none") {
	    		  $("#newAddUserBtnArea").css("display", "block")
	    	  } else {
	    		  $("#newAddUserBtnArea").css("display", "none")
	    	  }
	      });
	      
	      $("#newAddUserBtn").click(function() {
	    	  $("#userPopupArea").css("display", "flex");
	    	  $("#addUserPopup").css("display", "block");
	      });
	      
	      $(".button-close.js-close-button").click(function() {
	    	  $("#userPopupArea").css("display", "none");
	    	  $(this).parent().parent().css("display", "none");
	      });
	      
	      $(".button-org-pop.js-open-orgchart-popup").click(function() {
	    	  $("#orgChartPopup").css("display", "block");
	    	  $("#addUserPopup").css("display", "none");
	      });
	      
	      $("#returnDvsnChange").click(function() {
	    	  $("#orgChartPopup").css("display", "none");
	    	  $("#addUserPopup").css("display", "block");
	      });
	      
	      
	      

	      $(".edit_bt.btn.btn_style1").click(function() { // 회사명 수정
	        parent_id = $(this).parent().attr("id");
// 	        alert(parent_id);
	        $(this).css("display", "none");
	        $(this).parent().find(".save_bt.btn.btn_style1.bgblue").css("display", "inline-block");
	        $(this).parent().find(".cancel_bt.btn.btn_style1").css("display", "inline-block");
	        defalut_name = $(this).parent().find('input[type="text"]').val();
	        $(this).parent().find('input[type="text"]').removeAttr("disabled");
	        if(parent_id=="domain") {
	        	$(this).parent().find('input[type="text"]').val($(this).parent().find('input[type="text"]').val().replace("https://", "").replace(".with.team", ""));
	        }
	      });
	      
	      

	      $(".cancel_bt.btn.btn_style1").click(function() {
	        $(this).css("display", "none");
	        $(this).parent().find(".save_bt.btn.btn_style1.bgblue").css("display", "none");
	        $(this).parent().find(".edit_bt.btn.btn_style1").css("display", "inline-block");
	        $(this).parent().find('input[type="text"]').val(defalut_name);
	        $(this).parent().find('input[type="text"]').attr("disabled", "disabled");
	      });
	      

	      $(".save_bt.btn.btn_style1").click(function() {
// 	    	alert($("#comm input").val());
// 	    	company_name = $("#comm input").val();
	        $(this).css("display", "none");
	        $(this).parent().find(".cancel_bt.btn.btn_style1").css("display", "none");
	        $(this).parent().find(".edit_bt.btn.btn_style1").css("display", "inline-block");
	        $(this).parent().find('input[type="text"]').attr("disabled", "disabled");
// 	        alert(parent_id);
	        if(parent_id=="comm") {
	          company_name_correction();
	          $(".alert_box").css("display", "block");
	          setTimeout(function() {
	            $(".alert_box").css("display", "none");
	          }, 2000);
	        } else if(parent_id=="domain") {
	        	  $(this).parent().find('input[type="text"]').val("https://" + $(this).parent().find('input[type="text"]').val() + ".with.team");
//	        	  alert("SSSSSSSsss");
	        	  company_url_correction();
	        	  $(".alert_box2").css("display", "block");
		          setTimeout(function() {
		            $(".alert_box2").css("display", "none");
		          }, 2000);
	          } else {
//	        	  alert("@@");
				  if(defalut_name=="") {
				  	  admin_log_add("직원 참여 옵션 변경", "", "관리자의 가입 승인 완료 후 참여" + " → 특정도메인의 이메일 바로 참여'" + $("#comm_domain input").val() + "'");
				  } else{
	 				  admin_log_add("직원 참여 옵션 변경", "", "특정도메인의 이메일 바로 참여'" + $("#comm_domain input").val() + "'" + " → 특정도메인의 이메일 바로 참여'" + $("#comm_domain input").val() + "'");
				  }
		      	  company_join_option_correction();
	          }
	        
	      });
	      
	      
	      
//	      $("tr").on("click", "td:nth-child(5), td:nth-child(2), td:nth-child(3), td:nth-child(4), td:nth-child(6), td:nth-child(7)", function() {
//	    	$("#userPopupArea").css("display", "flex");
//	    	$("#addUserPopup").css("display", "block");
//	      });
	      
	      $(document).on('click', '#editLodo', function () {
//	    	alert("#");
	    	$("#collabo_mod_bg_layer1").css("display", "block"); 
	      	$("#uploadLogoPopup").css("display", "block");
	      	file_box = $("#file_box").html();
//	      	alert(file_box);
	      });
	      
	      $("#deleteLogo").click(function() {
	    	$(".pop_logoimg_cont2").html('<input type="file" id="abc" style="transform: translateY(-50%); top: 50%; position: relative; max-height: 142px; max-width: 408px;"/>');
	    	$(".ico_edit_btn_wrap").css("display", "none");
	    	$("#logoGuide").css("display", "block");
	    	$("#logoDragAndDropDiv").css("display", "block");
	    	
	      });
	    
	      $('span[data-langcode="FA1462"]').click(function() {
//	    	alert("!");
	    	$("#collabo_mod_bg_layer1").css("display", "none"); 
	      	$("#uploadLogoPopup").css("display", "none");
	      	$("#file_box").html(file_box);
	      	$(".ico_edit_btn_wrap").css("display", "block");
	    	$("#logoGuide").css("display", "none");
	    	$("#logoDragAndDropDiv").css("display", "none");
	      });
	      
	      $('span[data-langcode="FA1461"]').click(function() {
	    	  file_box = $("#file_box").html();
	    	  file_name = file_name.replace("C:\\fakepath\\", "Images/");
	    	  $(".inlogoimg").html("<img src='" + file_name + "' name='new_img' />");
	    	  $(".inlogoimg [name='new_img']").attr("name", "title_img");
	    	  $("[name='title_img']").attr("style", "position: relative; max-height: 55px; max-width: 280px;");
	    	  $(".inlogoimg").append('<a class="edit_img" id="editLodo" data-langcode="CCM1303">편집 및 삭제</a>');
	    	  
	    	  $("#collabo_mod_bg_layer1").css("display", "none"); 
		      $("#uploadLogoPopup").css("display", "none");
		      $(".ico_edit_btn_wrap").css("display", "block");
		      $("#logoGuide").css("display", "none");
		      $("#logoDragAndDropDiv").css("display", "none");
//		      alert(file_name);
		      company_img_correction();
	      });
	      
	      $("#reUpload").click(function() {
	    	$(".ico_edit_btn_wrap").css("display", "block");
		    $("#logoGuide").css("display", "none");
		    $("#logoDragAndDropDiv").css("display", "none");
	      });
	      
	      
	      $(document).on('change', '#abc', function(e) {
	    	  let file = e.target.files[0];
	    	  file_name = $("#file_box input").val();
//	    	  alert(file_name);
	    	  // 이미지 파일인지 확인
	    	  if (file && file.type.startsWith('image/')) {
	    	    let reader = new FileReader();
	    	    
	    	    // 파일을 읽어서 미리보기 이미지로 설정
	    	    reader.onload = function(e) {
	    	      previewImage = $('<img name="new_img" /> ');
	    	      previewImage.attr('src', e.target.result);
	    	      $("#file_box").html(previewImage);
//	    	      alert("e");
	    	      $("[name='new_img']").attr("style", "transform: translateY(-50%); top: 50%; position: relative; max-height: 142px; max-width: 408px;");
	    	    };
	    	    
	    	    reader.readAsDataURL(file);
	    	  }
	      });
	      
	      
	    	  
	      $("input[name='teamSignup']").click(function() {
	    	  // 선택 여부 확인
	    	  if ($("#teamSet2").is(":checked")) {
	    	   	$("#comm_domain").css("display", "inline-block");
	    	   	$("#comm_domain .edit_bt.btn.btn_style1").css("display", "inline-block");
	    	   	$("#comm_domain .cancel_bt.btn.btn_style1").css("display", "none");
	    	   	$("#comm_domain .save_bt.btn.btn_style1").css("display", "none");
	    	    // 추가 작업 수행
	    	  } else if($("#comm_domain input").val()!=""){
	    		  if(confirm("특정 도메인의 이메일 리스트가 사라집니다. 그래도 설정하시겠습니까?")) {
		    		  $("#comm_domain").css("display", "none");
 					  admin_log_add("직원 참여 옵션 변경", "", "특정도메인의 이메일 바로 참여'" + $("#comm_domain input").val() + "'" + " → 관리자의 가입 승인 완료 후 참여");
		    		  $("#comm_domain input").val("");
		    		  company_join_option_correction();
	    		  } else {
	    			  $("#teamSet2").prop('checked', true);
	    		  }
	    	  }
	      });
	      
	      // @#
	      $(document).on("click", ".tbold_uline", function() {
	    	  let tu = true;
	    	  employee_id = $(this).parent().parent().attr("user_id");
	    	  if($(this).parent().parent().parent().attr("id") == "normalUserList") {
	    		  if(employee_id==my_id) {
		    		  	alert("본인 스스로 이용중지하거나 관리자 권한을 삭제할 수 없습니다.")
		    		  	tu = false;
		    	  }
	    		  UserList = 1;
	    		  $("#confirm .confirm-content-area div p").text("이용중지 처리하시겠습니까?");
	    	  } else if($(this).parent().parent().parent().attr("id") == "stopUserList") {
	    		  UserList = 2;
	    		  $("#confirm .confirm-content-area div p").text("이용중지 해제하시겠습니까?");
	    	  }
	    	  
	    	  if($(this).text()=="[승인]") {
	    		  UserList = 3;
	    		  $("#confirm .confirm-content-area div p").text("가입 승인하시겠습니까?");
	    	  } else if($(this).text()=="[거절]") {
	    		  UserList = 4;
	    		  $("#confirm .confirm-content-area div p").text("가입 거절하시겠습니까?");
	    	  } else if($(this).text()=="삭제") {
	    		  $("#confirm .confirm-content-area div p").text("구성원 삭제(계정 삭제) 하시겠습니까?");
	    		  UserList = 4;
	    	  } else if($(this).text()=="[지정]") {
	    		  $("#confirm .confirm-content-area div p").text("관리자 권한을 부여하시겠습니까?");
	    		  UserList = 5;
	    	  } else if($(this).text()=="[삭제]") {
	    		  $("#confirm .confirm-content-area div p").text("관리자 권한을 삭제하시겠습니까?");
	    		  UserList = 6;
	    	  }
	    	  
	    	  if(tu) {
	    	  	$("#confirm").css("display", "flex");
	    	  }
	      });
	      
	      $("#confirm .cancel").click(function() {
	    	  $("#confirm").css("display", "none");
	      });
	      
	      
	      $("#confirm .submit").click(function() {
	    	  if(UserList==1) {
	    		  employee_status_correction_2();  
	    	  } else if(UserList==2) {
	    		  employee_status_correction_1(); 
	    	  } else if(UserList==3) {
	    		  employee_status_correction_1(); 
	    	  } else if(UserList==4) {
	    		  employee_delete();
	    	  } else if(UserList==5) {
	    		  employee_company_admin_1();
	    	  } else if(UserList==6) {
	    		  employee_company_admin_0();
	    	  }
	    	  
	    	  setTimeout(function() {
	    	      employees_manage_load();
	    	  }, 10);
	    	  
	    	  $("#confirm").css("display", "none");
	      });
	      
	      
	      
	      
	      
	      $(".js-user-check input[type='checkbox']").change(function() {
	    	  if ($(this).is(":checked")) {
	    		  checkbox_plus();
				} else {
					// 체크박스가 체크 해제되었을 때 실행할 코드 작성
					if(checkbox_count>0){
					checkbox_minus();
					$("#checkUserCnt").text(checkbox_count);
					$("#checkAllUser").prop("checked", false);
					}
				}
	    	  if(checkbox_count==0) {
	    		  $("#changeDvsnArea").css("display", "none");
	  		  	$("#tableSearchArea").css("display", "flex");
	    	  }
	      });
	      
	      
	      $("#checkAllUser").change(function() {
	    	  if ($(this).is(":checked")) {
	    		  $(".js-user-check input[type='checkbox']").prop("checked", true);
	    		  checkbox_count = $("#normalUserList").find("tr").length;
	    		  $("#checkUserCnt").text(checkbox_count);
				} else {
				  $(".js-user-check input[type='checkbox']").prop("checked", false);
				  checkbox_count = 0;
				  $("#checkUserCnt").text(checkbox_count);
				}
	    	  if(checkbox_count==0) {
	    		  $("#changeDvsnArea").css("display", "none");
	  		  	$("#tableSearchArea").css("display", "flex");
	    	  }
	      });
	      
	      
	      $("td[mngr-dscn] .tbold_uline").click(function() {
	    	  if($(this).parent().attr("mngr-dscn")=="F") {
			    	 $(this).css("color", "blue");
			    	 $(this).text("[지정]");
			    	 $(this).parent().find("span").text("N");
			    	 $(this).parent().attr("mngr-dscn", "C");
	    	  } else {
			    	 $(this).css("color", "red");
			    	 $(this).text("[삭제]");
			    	 $(this).parent().find("span").text("Y");
			    	 $(this).parent().attr("mngr-dscn", "F");
	    	  }
		  });
	      
	      $(".tbold_uline").click(function() {
	    	 if($(this).text()=="[보기]") {
//	    		 alert("%");
	    		$("#deviceLayer").css("display", "block");
	    	 } 
	      });
	      
	      
	      $.datepicker.setDefaults({
			    dateFormat: 'yy-mm-dd',
			    showOtherMonths: true,
			    showMonthAfterYear: true,
			    changeYear: true,
			    changeMonth: true,
			    yearSuffix: "년",
			    monthNamesShort: ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12'],
			    monthNames: ['1월', '2월', '3월', '4월', '5월', '6월', '7월', '8월', '9월', '10월', '11월', '12월'],
			    dayNamesMin: ['일', '월', '화', '수', '목', '금', '토'],
			    dayNames: ['일요일', '월요일', '화요일', '수요일', '목요일', '금요일', '토요일'],
			    minDate: new Date(2023, 0, 1), // 선택 가능한 가장 빠른 날짜 (2023년 1월 1일)
			    maxDate: new Date(new Date().getTime() + 24 * 60 * 60 * 1000) // 선택 가능한 가장 늦은 날짜 (2023년 12월 31일)
			});
	      
	      
	      $("#USE_SCHD_STTG_DT").datepicker();
	      $("#USE_SCHD_FNSH_DT").datepicker();
	      $("#USE_SCHD_STTG_DT").datepicker('setDate', '-6M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	        //To의 초기값을 내일로 설정
	      $("#USE_SCHD_FNSH_DT").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	      
		  $("#USER_SCHD_STTG_DT").datepicker();
	      $("#USER_SCHD_FNSH_DT").datepicker();
	      $("#USER_SCHD_STTG_DT").datepicker('setDate', '-6M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	        //To의 초기값을 내일로 설정
	      $("#USER_SCHD_FNSH_DT").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)	      

		  
		  $("#EDIT_LOG_SCHD_STTG_DT").datepicker();
	      $("#EDIT_LOG_SCHD_FNSH_DT").datepicker();
	      $("#EDIT_LOG_SCHD_STTG_DT").datepicker('setDate', '-6M'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)
	        //To의 초기값을 내일로 설정
	      $("#EDIT_LOG_SCHD_FNSH_DT").datepicker('setDate', 'today'); //(-1D:하루전, -1M:한달전, -1Y:일년전), (+1D:하루후, -1M:한달후, -1Y:일년후)



		  $(document).on("click", "#useStatPrjScroll tr", function() {
			  $(".ngrAlert").css("display","none");
	    	  let project_id = $(this).attr("project_id");
			  p_id = project_id;
			  p_name = $(this).find("td:first-child").text();
			  $("#addProjLayer2").find('span[data-langcode="FA1834"]').text("프로젝트 정보");
	    	  project_information_load(project_id);
			  setTimeout(function() {
	      		  project_information_load_member(project_id);
	    	  }, 100);
	    	  setTimeout(function() {
	      		  $("#addProjLayer2").css("display", "block");
	    	  }, 100);
	      });
	      
	      
	      $("#addProjLayer2 input.pop_close").click(function() {
	    	  $("#addProjLayer2").css("display", "none");
//	    	  alert("#");
	      });
	      
	      $("#save-or-edit2 + a").click(function() {
//	    	 alert("프로젝트 정보 취소버튼"); 
	    	 $("#addProjLayer2").css("display", "none");
	      });

		  $("#save-or-edit2").click(function() {
			let inputText = $("#addProjLayer2 input[name='proj_name']").val();
    		let textLength = inputText.length;
			if(textLength<3) {
				$(".ngrAlert").css("display","block");
			} else {
//			alert("!");
			let num1;
			let num2;
			let num3;
			let num4;
			let num5;
			let project_id = $("#addProjLayer2 input[name='proj_name']").attr("project_id");
			let project_name = $("#addProjLayer2 input[name='proj_name']").val();
			 
			if ($("#prj_mngr_wr_yn_area input[name='prj_mngr_wr_yn'][value='N']").prop('checked')) {
//			    alert("1A");
				num1 = 0;
			} else if ($("#prj_mngr_wr_yn_area input[name='prj_mngr_wr_yn'][value='Y']").prop('checked')) {
//			    alert("2A");
				num1 = 1;
			}
        	
        	if($("#prj_mngr_wr_cm_yn_area input[name='prj_mngr_wr_cm_yn'][value='N']").prop("checked")) {
//        		alert("1B");
				num2 = 0;
        	} else if($("#prj_mngr_wr_cm_yn_area input[name='prj_mngr_wr_cm_yn'][value='Y']").prop("checked")) {
//				alert("2B");
				num2 = 1;
        	}
        	
        	if($("input[name='omprj_srch_auth_yn'][value='N']").prop("checked")) {
//        		alert("1C");
				num3 = 0;
        	} else if($("input[name='omprj_srch_auth_yn'][value='Y']").prop("checked")) {
//        		alert("2C");
				num3 = 1;
        	}
  	    	
			if($("input[name='omprj_prj_auth'][value='N']").prop("checked")) {
//				alert("1D");
				num4 = 0;
        	} else if($("input[name='omprj_prj_auth'][value='Y']").prop("checked")) {
//        		alert("2D");
				num4 = 1;
        	}
		
			if($("input[name='riteEditAuth'][value='MNGRMYSELF']").prop("checked")) {
//        		alert("1E");
				num5 = 0;
        	} else if($("input[name='riteEditAuth'][value='MYSELF']").prop("checked")) {
//        		alert("2E");
				num5 = 1;
        	}

			project_information_correction(project_id, num1, num2, num3, num4, num5, project_name);
			setTimeout(function() {
			     project_manage_load();
			}, 10);
			$("#addProjLayer2").css("display", "none");
			
			}
			 
		  });
			
		  
	      
	      $("#mngrAdd2").click(function(){
	    	  $("#proj_mngr_layer2").css("display", "block"); 
	    	  $(".bgmodal").css("display", "block");
	      });
	      
	      $(".layer_popup_top .pop_close").click(function() {
//	    	  alert("!!");
	    	  $("#proj_mngr_layer2").css("display", "none"); 
	    	  $(".bgmodal").css("display", "none");
	      });
	      
	      $("#del_proj2").click(function() {
	    	  if(confirm("프로젝트를 삭제하시겠습니까?")) {
	    		  $("#addProjLayer2").css("display", "none");
				  let project_id = $("#addProjLayer2 input[name='proj_name']").attr("project_id");
				  project_delete(project_id);
				  setTimeout(function() {
			          project_manage_load();
			      }, 100);
	    	  } else {
	    		  
	    	  }
	      });
	      
	      $(document).on("click", ".out_bt.tbold_uline", function() {
			 employee_id = $(this).parent().parent().find(".user_ids").text();
	    	 if($(this).hasClass("admin-selecte")) {
				 project_information_admin_correction_1(p_id);
	    		 $(this).removeClass("admin-selecte").addClass("admin-release");
	    		 $(this).text("관리자[해제]");
	    	 } else {
//	    		 alert($(this).parent().parent().parent().find(".out_bt.tbold_uline.admin-release").length);
	    		 if($(this).parent().parent().parent().find(".out_bt.tbold_uline.admin-release").length==1) {
	    			  $(".alert_box").css("display", "block");
			          setTimeout(function() {
			          $(".alert_box").css("display", "none");
			          }, 20000);
	    		 } else {
					 project_information_admin_correction_0(p_id);
		    		 $(this).removeClass("admin-release").addClass("admin-selecte");
		    		 $(this).text("정상[선택]");
	    		 }
	    	 }
	    	 
	      });
	      
	      $("#addProjBtn").click(function() {
			 $("#회사_프로젝트_정보_수정 input[name='proj_name']").val("");
			 $("#mngr_tbody_2").html("");
			 $("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_yn'][value='N']").prop("checked", true);
			 $("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_cm_yn'][value='N']").prop("checked", true);
			 $("#회사_프로젝트_정보_수정 input[name='mprj_srch_auth_yn'][value='N']").prop("checked", true);
			 $("#회사_프로젝트_정보_수정 input[name='mprj_prj_auth'][value='N']").prop("checked", true);
			 $("#회사_프로젝트_정보_수정 input[name='iteEditAuth'][value='MNGRMYSELF']").prop("checked", true);
			 $("#del_proj_2").css("display", "none");
			 $("#save-or-edit_2").text("저장");
			 my_load();
		
			 
	    	 $("#addProjLayer").css("display", "block");
	    	 $("#회사_프로젝트_정보_수정").css("display", "block");	    	 
	      });
	      
	      $("#회사_프로젝트_정보_취소").click(function() {
		     $("#addProjLayer").css("display", "none");
		     $("#회사_프로젝트_정보_추가").css("display", "none");
		  });
	      
	      $("#회사_프로젝트_정보_X").click(function() {
		     $("#addProjLayer").css("display", "none");
		     $("#회사_프로젝트_정보_추가").css("display", "none");
		  });
	      
	      
	      //M
	      $(document).on("click", "#comm_proj_tbody tr",function() {
//			  alert("T");
			  $("#del_proj_2").css("display", "inline-block");
			  $(".grAlert").css("display", "none");
			  $("#save-or-edit_2").text("수정");
			  let project_id = $(this).attr("project_id");
		      p_id = project_id;
			  p_name = $(this).find("td:eq(2)").text();
			  company_project_information_load(project_id);
			  $("#회사_프로젝트_정보_수정 input[name='proj_name']").val($(this).find('td[style="text-align: left; padding-left: 10px;"]').text());
			  setTimeout(function() {
			  	company_project_information_load_member(project_id);
			  }, 100);
			  
			  setTimeout(function() {
			  	$("#addProjLayer").css("display", "block");
			  }, 100);
	    	  $("#회사_프로젝트_정보_수정").css("display", "block");
	      });
	      
	      $("#회사_프로젝트_정보_수정 .lyaer_popup_top input").click(function() {
//	    	  alert("@");
	    	  $("#addProjLayer").css("display", "none");
	    	  $("#회사_프로젝트_정보_수정").css("display", "none");
	      });
	      
	      $("#회사_프로젝트_정보_수정 .lyaer_popup_cont .t_center .pop_close").click(function() {
//	    	  alert("취~소");
	    	  $("#addProjLayer").css("display", "none");
	    	  $("#회사_프로젝트_정보_수정").css("display", "none");
	      });
			

		  $(document).on('click', '#open_proj_tbody tr', function () {
			  let project_id = $(this).attr("project_id");
			  let category = $(this).find("td:first").text();
			  p_name = $(this).find("td:eq(1)").text();
			  p_id = project_id;
			  $(".grAlert").hide();
			  open_project_information_load(project_id);
	
			  setTimeout(function() {
			  	open_project_information_load_member(project_id);
			  }, 50);
	
			  setTimeout(function() {
			  	open_project_information_load_category(project_id);
			  }, 50);
	
			  setTimeout(function() {
			  	$("#projEditPopUp").css("display", "block");
			  }, 100);
			  
			
	      });
	      
	      
	      $("#projEditPopUp .pop_close").click(function() {
//	    	 alert("공개_프로젝트_관리_취소, X");
	    	 $("#projEditPopUp").css("display", "none");
			
	      });


		  $("#save-or-edit_2").click(function() {
			
			let inputText = $("#회사_프로젝트_정보_수정 input[name='proj_name']").val();
    		let textLength = inputText.length;
			if(textLength<3) {
				$(".grAlert").css("display","block");
			} else {
				let num1;
					let num2;
					let num3;
					let num4;
					let num5;
					let project_id = $("#회사_프로젝트_정보_수정 input[name='proj_name']").attr("project_id");
					let project_name = $("#회사_프로젝트_정보_수정 input[name='proj_name']").val();
					
					if($("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_yn'][value='N']").prop("checked")) {
		        		num1 = 0;
		        	} else if($("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_yn'][value='Y']").prop("checked")) {
						num1 = 1;
		        	}
		
					if($("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_cm_yn'][value='N']").prop("checked")) {
		        		num2 = 0;
		        	} else if($("#회사_프로젝트_정보_수정 input[name='mprj_mngr_wr_cm_yn'][value='Y']").prop("checked")) {
						num2 = 1;
		        	}
		
					if($("#회사_프로젝트_정보_수정 input[name='mprj_srch_auth_yn'][value='N']").prop("checked")) {
		        		num3 = 0;
		        	} else if($("#회사_프로젝트_정보_수정 input[name='mprj_srch_auth_yn'][value='Y']").prop("checked")) {
						num3 = 1;
		        	}
		
					if($("#회사_프로젝트_정보_수정 input[name='mprj_prj_auth'][value='N']").prop("checked")) {
		        		num4 = 0;
		        	} else if($("#회사_프로젝트_정보_수정 input[name='mprj_prj_auth'][value='Y']").prop("checked")) {
						num4 = 1;
		        	}
		        	
		        	if($("#회사_프로젝트_정보_수정 input[name='iteEditAuth'][value='MNGRMYSELF']").prop("checked")) {
		        		num5 = 0;
		        	} else if($("#회사_프로젝트_정보_수정 input[name='iteEditAuth'][value='MYSELF']").prop("checked")) {
						num5 = 1;
		        	}
				if($("#save-or-edit_2").text()=="저장") {
					company_project_create(num1, num2, num3, num4, num5, project_name);
					
				} else if($("#save-or-edit_2").text()=="수정") {
					project_information_correction(project_id, num1, num2, num3, num4, num5, project_name);
				}
				$("#addProjLayer").css("display", "none");
				$("#회사_프로젝트_정보_수정").css("display", "none");
				setTimeout(function() {
					company_project_manage_load();
				}, 10);
			}
		  });


		  $("#del_proj_2").click(function() {
			if(confirm("프로젝트를 삭제하시겠습니까?")) { 
				  let project_id = $("#회사_프로젝트_정보_수정 input[name='proj_name']").attr("project_id");
				  project_delete(project_id);
				  setTimeout(function() {
			          company_project_manage_load();
			      }, 100);
				$("#addProjLayer").css("display", "none");
				$("#회사_프로젝트_정보_수정").css("display", "none");
	    	  } else {
	    		  
	    	  }
		  });


		  $("#del_open_proj").click(function() {
			if(confirm("프로젝트를 삭제하시겠습니까?")) { 
				  let project_id = $("#projEditPopUp input[name='open_proj_name']").attr("project_id");
				  project_delete(project_id);
				  setTimeout(function() {
			          open_project_manage_load();
			      }, 100);
				$("#projEditPopUp").css("display", "none");
	    	  } else {
	    		  
	    	  }
		  });

		  $("#projEditSubmit").click(function() {
			
			let inputText = $("#projEditPopUp input[name='open_proj_name']").val();
    		let textLength = inputText.length;
			if(textLength<3) {
				$(".grAlert").css("display","block");
			} else {
				let num1;
				let num2;
				let num3;
				let num4;
				let num5;
				let project_id = $("#projEditPopUp input[name='open_proj_name']").attr("project_id");
				let project_name = $("#projEditPopUp input[name='open_proj_name']").val();
				
				if($("#projEditPopUp input[name='openmngr_wr_yn'][value='N']").prop("checked")) {
		       		num1 = 0;
		       	} else if($("#projEditPopUp input[name='openmngr_wr_yn'][value='Y']").prop("checked")) {
					num1 = 1;
		       	}
	
				if($("#projEditPopUp input[name='openmngr_wr_cm_yn'][value='N']").prop("checked")) {
	        		num2 = 0;
	        	} else if($("#projEditPopUp input[name='openmngr_wr_cm_yn'][value='Y']").prop("checked")) {
					num2 = 1;
	        	}	
	
				if($("#projEditPopUp input[name='srch_auth_yn'][value='N']").prop("checked")) {
	        		num3 = 0;
	        	} else if($("#projEditPopUp input[name='srch_auth_yn'][value='Y']").prop("checked")) {
					num3 = 1;
	        	}
	
				if($("#projEditPopUp input[name='prj_auth'][value='N']").prop("checked")) {
	        		num4 = 0;
	        	} else if($("#projEditPopUp input[name='prj_auth'][value='Y']").prop("checked")) {
					num4 = 1;
	        	}
	        	
	        	if($("#projEditPopUp input[name='writeEditAuth'][value='MNGRMYSELF']").prop("checked")) {
	        		num5 = 0;
	        	} else if($("#projEditPopUp input[name='writeEditAuth'][value='MYSELF']").prop("checked")) {
					num5 = 1;
	        	} 
				
				let category_id = $("#openProjectCategory").find('option:selected').attr("category_id");
				
				$("#projEditPopUp").css("display", "block");
				project_information_correction(project_id, num1, num2, num3, num4, num5, project_name);
				setTimeout(function() {
					project_information_correction_category(project_id, category_id);
				}, 10);
				setTimeout(function() {
					open_project_manage_load();
				}, 10);
				$("#projEditPopUp").hide();
			}
		  });


		



		$("#open_catg_save_bt").click(function() {
			
			let list = [];
			let boolean;
			$("#open_catg_tbody tr").each(function() {
				let category = $(this).find(".catg_input").val();
				list.push(category);
			});
			
			for(let i=0; i<list.length; i++) {
				for(let j=0; j<=i-1; j++) {
					if(list[i] == list[j]) {
						boolean=true;
					}
				}
			}
			
			if(boolean) {
				alert("카테고리명은 중복될 수 없습니다.");
			} else {
				
			
			
			$("#open_catg_tbody tr").each(function() {
				let category_id = $(this).attr("category_id");
				if (typeof category_id === 'undefined') {
					let category = $(this).find(".catg_input").val();
					
					let status;
					if($(this).find("option[value='Y']").prop("selected")==true) {
						status = 1;
					} else if ($(this).find("option[value='N']").prop("selected")==true) {
						status = 0;
					}
					
					let delete_;
					if($(this).css("display") == "none") {
					} else {
						delete_ = 0;
					}
					
					let add;
					if($(this).hasClass("add_stts")) {
						add = 1;
					} else {
						add = 0;
					}
					
					category_correction(category_id, category, status, delete_, add);
					admin_log_add("카테고리 추가", category, "");
				} else {
					let category = $(this).find(".catg_input").val();
					
					let status;
					if($(this).find("option[value='Y']").prop("selected")==true) {
						status = 1;
					} else if ($(this).find("option[value='N']").prop("selected")==true) {
						status = 0;
					}
					
					let delete_;
					if($(this).css("display") == "none") {
						delete_ = 1;
					} else {
						delete_ = 0;
					}
					
					let add;
					if($(this).hasClass("add_stts")) {
						add = 1;
					} else {
						add = 0;
					}
					
					
					category_correction(category_id, category, status, delete_, add);
					if(delete_==1) {
						admin_log_add("카테고리 삭제", category + "(" + category_id + ")" + "");
					} else {
						if(hashMapcatgTexts[$(this).attr("category_id")] != category) {
							admin_log_add("카테고리 수정", category + "(" + category_id + ")", "'" + hashMapcatgTexts[$(this).attr("category_id")] + "' → '" + category + "'");
						}
						if(hashMapcatgStatus[$(this).attr("category_id")] != status) {
							if(status == 1) {
								admin_log_add("카테고리 수정", category + "(" + category_id + ")", "비활성  → 활성");
							} else if(status == 0) {
								admin_log_add("카테고리 수정", category + "(" + category_id + ")", "활성  → 비활성");
								
							}
						}
					}
				}
				
			});
			
	    $("#open_catg_save_bt").css('display', 'none');
	    $("#open_catg_cancel_bt").css('display', 'none');
	    $("#open_catg_edit_bt").css('display', 'inline-block');
	    $("#open_catg_add_bt").css('display', 'none');
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .delete_bt").css('display', 'none');
	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .btn_drag").css('display', 'none');

	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .catg_td input.catg_input").each(function(index) {
	      let inputValue = $(this).val();
	     
	      $(this).parent().html(inputValue);
	    });

	    $("#공개_프로젝트_카테고리 .list_table #open_catg_tbody .use_yn select").each(function(index){
	    	let inputSelect = $(this).val();
	    	
	    	if(inputSelect=='Y'){
	    	$(this).parent().html('활성');
	    	}else{
	    	$(this).parent().html('비활성');
	    	}
	    });
	    
    	$( "#공개_프로젝트_카테고리 .list_table #open_catg_tbody .add_stts" ).removeClass( 'add_stts' );
	    
	    $("#open_catg_tbody>:hidden").remove();
	    setTimeout(function() {
	            category_load();
	    }, 100);
		}
	  });
		
			$("#PROJECT_SRCH_BTN").click(function() {
				let search_name = $("#project_srch_word").val();
				let start_date = $("#USE_SCHD_STTG_DT").val();
				let end_date = $("#USE_SCHD_FNSH_DT").val();
//				alert(start_date);
//				alert(end_date);
//				alert(search_name);
				project_search(search_name, start_date, end_date);
			});
			
			
			$("#srch-companyprj-bt").click(function() {
				let search_name = $("#comm_proj_srch_word").val();
				company_project_search(search_name);
			});
			
			$("#srch-openprj-bt").click(function() {
				let search_name = $("#open_proj_srch_word").val();
				open_project_search(search_name);
			});
			
			$("#USER_SRCH_BTN").click(function() {
				let search_name = $("#user_srch_word").val();
				usage_statistics_search(search_name);
			});
			
			$("#EDIT_LOG_SRCH_BTN").click(function() {
				let search_name = $("#edit_log_srch_word").val();
				let start_date = $("#EDIT_LOG_SCHD_STTG_DT").val();
				let end_date = $("#EDIT_LOG_SCHD_FNSH_DT").val();
				let search_gubun = $("#edit_log_search_gubun option:selected").attr("value");
				admin_log_load(search_name, start_date, end_date, search_gubun);
			});
	      
	      
		});

	      
	      
	      
		let checkbox_count = 0;
		
		function checkbox_plus() {
			$("#changeDvsnArea").css("display", "flex");
		  	$("#tableSearchArea").css("display", "none");
			checkbox_count++;
			$("#checkUserCnt").text(checkbox_count);
		}
		
		function checkbox_minus() {
				checkbox_count--;
				$("#checkUserCnt").text(checkbox_count);
		}
		
		function employee_invite() {
				$("#url_bx").val(company_URL);
		}
		