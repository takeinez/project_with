<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

%>

<%
	
%>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>어드민 - 위드</title>
	<link href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap" rel="stylesheet">
	<link href='http://fonts.googleapis.com/css?family=Roboto:400,300,100,500,700' rel='stylesheet' type='text/css'>
	<link href="https://fonts.googleapis.com/css2?family=Nanum+Gothic&display=swap" rel="stylesheet">
	<link rel="stylesheet" href="//cdn.jsdelivr.net/npm/font-applesdgothicneo@1.0/all.min.css">
	<link rel="stylesheet" href="css/어드민.css">
	<link rel="stylesheet" href="css/takeinAdmin.css">
	
	<script src="https://kit.fontawesome.com/42669b0565.js" crossorigin="anonymous"></script>
	<script src="js/jquery-3.7.0.min.js"></script>
	<script src="js/takeinAdmin.js"></script>
	<script src="js/2skyAdmin.js"></script>
	
	<script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
	<script src="js/어드민Ajax.js"></script>
	<link rel="stylesheet" href="//code.jquery.com/ui/1.12.1/themes/base/jquery-ui.css">
	
	<script>
	var company_id;
	var company_URL;
	var my_id = "<%=id%>";
	var disabled;
	function company_information_load() {
		$.ajax({
            url: "/webproject1/withServlet",		// 데이터를 가져올 경로 설정
            type: "POST",		// 데이터를 가져오는 방식
            data: {
            	send_number: 1,
            	send_employee_id: "<%=id%>"
            	},
            success: function(data){	// 데이터를 가져왔을때 동작. 매개변수로 data 입력
                console.log(data);
                var json = data;	// 가져온 데이터를 자바스크립트 객체로 변환해주는 작업이 필요
//	                alert("연결성공");                                    	// trim()을 통해 불필요한 여백 제거
                for (var i = 0; i < json.length; i++) {
                	company_id = json[i].company_id;
//	                	alert("company" + company_id);
                	let company_name = json[i].company_name;
                	company_URL = json[i].company_URL;
                	let company_img = json[i].company_img;
                	let company_join_option = json[i].company_join_option;
                	let use_department = json[i].use_department;
                	disabled = use_department;
                	
                	if(disabled == 1) {
                		$("#activeOrgCheckbox").attr("checked", "")
                	        $( "#disabledOrgArea" ).addClass( 'able' );
                	        $( "#excelRegistration" ).addClass( 'color-change1' );
                	        $( "#excelRegistration" ).removeClass( 'bgblue2' );
                	        $( "#excelRegistration" ).removeAttr( "disabled", true );
                	        $( "#orgChartUseText" ).text( "사용");
                	        
//                 	        if(!($("#orgChartTree .tui-tree-node").hasClass("tui-tree-node"))){ //이미 하나라도 있으면 안뜨게.
// //                 	        $("#orgChartNoneData").css('display','flex');
//                     	    }
                	        $("#orgChartTree").css('display','block');
                    	  }
                    	  else{
                	        $( "#disabledOrgArea" ).removeClass( 'able' );
                	        $( "#excelRegistration" ).addClass( 'bgblue2' );
                	        $( "#excelRegistration" ).removeClass( 'color-change1' );
                	        $( "#excelRegistration" ).attr( "disabled", true );
                	        $( "#orgChartUseText" ).text( "비활성");
                    	  }
                	
//	                    alert(company_join_option);
                    $("#comm input").val(company_name);
                    $(".inlogoimg img").attr("src", company_img);
                    $(".inlogoimg img").attr("name", "title_img");
	      	    	$("[name='title_img']").attr("style", "position: relative; max-height: 55px; max-width: 280px;");
	      	    	$("#file_box").html('<img src="' + company_img + '" alt="" style="transform: translateY(-50%); top: 50%; position: relative; max-height: 142px; max-width: 408px;" thum_img_path="https://flow.team/flowImg/FLOW_202306143129656_b1d7faa3-08eb-48c7-8244-3d7bca88df81.png" atch_srno="53291875">');
	      	    	$("#domain input").val(company_URL);
	      	    	if(company_join_option==null) {
	      	    		$("#teamSet1").attr("checked" , "")
	      	    	} else {
	      	    		$("#teamSet2").attr("checked" , "")
	      	    		$("#comm_domain input").val(company_join_option);
	      	    		$("#comm_domain").css("display", "inline-block");
	      	    	}
               	 	$("#dvsnUseInttId").text(company_name);
	      	    	
                }
                
            }
        })
	}
	</script>
</head>
<body>
	<div class="wrap">
		<div class="container">
			<span id="with-admin-left" class="with-admin-left">
				<div class="lnb-box">
					<div class="lnb-top">
						<div class="cibox">
							<div class="logo-display-wrap">
								<img class="logo-with" src="Images/with_logo.png" alt="with" >
							</div>
						</div>
					</div>
					<div id="adminLeftMenu" class="lnb-menu-box mCustomScrollbar _mCS_12" style="display:block;">
						<div id="mCSB_12" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height:720px;    overflow: scroll;">
							<div id="mCSB_12_container" class="mCSB_container" style="position:relative;top:0;left:0;" dir="ltr">
								<h2 class="title-admin">회사</h2>
								<div class="h3-box">
									<h3 id = "abc" data="with-company" class="with-admin-menu with-company on" data-langcode="FA1419">회사 정보</h3>
									<h3 data="with-user" class="with-admin-menu with-user" data-langcode="FA1420">구성원 관리</h3>
									<h3 data="with-invite" class="with-admin-menu with-invite" data-langcode="FA1421">구성원 초대</h3>
									<h3 data="with-org-management" class="with-admin-menu with-org-management" data-langcode="ORG002">조직도 관리</h3>
								</div>
								<h2 data="with-project-title" class="title-admin">프로젝트</h2>
								<div class="h3-box">
									<h3 data="with-proj-manage" class="with-admin-menu with-proj-manage">프로젝트 관리</h3>
						            <h3 data="with-comm-proj" class="with-admin-menu with-comm-proj">회사 프로젝트 관리</h3>
						            <h3 data="with-open-proj" class="with-admin-menu with-open-proj">공개 프로젝트 관리</h3>
						            <h3 data="with-open-proj-ctgr" class="with-admin-menu with-open-proj-ctgr">공개 프로젝트 카테고리</h3>
								</div>
								<h2 data="with-analyse-title" class="title-admin">통계/리포트</h2>
								<div class="h3-box">
						            <h3 data="with-acces-stat" class="with-admin-menu with-acces-stat">접속 통계</h3>
						            <h3 data="with-use-stat" class="with-admin-menu with-use-stat">사용 통계</h3>
						        </div>
						        <h2 data="with-security-title" class="title-admin" data-langcode="FA1715">보안 설정</h2>
						        <div class="h3-box">
				                    <h3 data="with-file-security" class="with-admin-menu with-file-security">파일 보안 설정</h3>
				                    <h3 data="with-login-security" class="with-admin-menu with-login-security">로그인 보안 설정</h3>
				        		</div>
				        		<h2 data="with-log" class="title-admin" data-langcode="DFA573">로그</h2>
				        		<div class="h3-box">
						            <h3 data="with-down-hstr" class="with-admin-menu with-down-hstr">파일 다운로드 이력</h3>
						            <h3 data="with-edit-log" class="with-admin-menu with-edit-log">관리자 변경 이력</h3>
						        </div>
						        <h2 data="with-payment-title" class="title-admin with-pay">결제</h2>
						        <div class="with-pay-content h3-box">
					                <h3 data="with-pay-info" class="with-admin-menu with-pay-info" style="">결제 정보</h3>
					            </div>
					            <div class="gov-voucher-banner admin">
						            <a href="https://sites.google.com/flow.team/2023goodchance?utm_source=service&utm_medium=admin&utm_campaign=voucher2023&quot;" target="_blank">
						                <img src="https://flow.team/flow-renewal/homepage/flow/ko/assets/images/logo_gov_cir.svg" alt="정부 로고" class="mCS_img_loaded">
						                <p>정부 지원금 <span>최대 200만원</span> 받기</p>
						            </a>
						        </div>
							</div>
						</div>
					</div>
					
					<div id="additionalInfo">
						<a href="https://support.flow.team/hc/ko/categories/4750281037081" target="help" rel="noopener noreferrer" class="admin-menual-btn" style="text-decoration:underline #fff;">
						<i class="fa-solid fa-download"></i>
						관리자 도움말
						</a>
					</div>
				</div>
			</span>
			<div class="content">
				<div id = "layoutArea" class="content_wrap">
				
				
					<span id="회사_정보" class="left_menu" style="display: inline;"> <!-- 회사정보 시작  -->
						<div class="titleh1_style">
							<div><h1 id="flow-company-title">회사 정보</h1></div>
						</div>
						
						<div class="payment_cont topline_none">
							<dl>
								<dt>회사명</dt>
								<dd>
									<div class="input_bx">
										<span id="comm">
											<input type="text" maxlength="20" disabled="disabled" value=""/>
											<button class="edit_bt btn btn_style1" data-langcode="CB1228">수정</button>
											<button class="save_bt btn btn_style1 bgblue" data-langcode="CT927" style="display: none;">저장</button>
											<button class="cancel_bt btn btn_style1" data-langcode="CD755" style="display: none;">취소</button>
										</span>
									</div>
								</dd>
								<dt data-langcode="CCM1301">로고 설정</dt>
								<dd class="logo_wrap">
									<div class="img_logo_cont">
										<input id="comp-logo-upload" type="file" accept="image/*" style="display:none;">
										<a class="inpt_img" id="uploadLogo" style="display: none;" data-langcode="CLP1098">로고 등록</a>
										<div class="inlogoimg" data="https://flow.team/flowImg/FLOW_202306143129656_b1d7faa3-08eb-48c7-8244-3d7bca88df81.png">
											<img src="">
											<a class="edit_img" id="editLodo" data-langcode="CCM1303">편집 및 삭제</a>
										</div>
									</div>
									<p class="info mgt5" data-langcode="FA1479">권장사항 - 400*100px, PNG / 최대 500KB</p>
								</dd>
							</dl>
						</div>
						
						<div id="BFLOW_CONT" class="payment_cont">
							<dl>
								<dt data-langcode="FA1480">전용 URL</dt>
								<dd>
									<p class="mgb15" data-langcode="FA1481">전용 URL 주소를 전달하여 회사 직원들을 참여시킬 수 있습니다.</p>
									<div class="input_bx">
										<span id="domain">
											<input type="text" maxlength="20" value="" disabled="disabled" style="font-weight:bold;color:#307cff;">
											<button class="edit_bt btn btn_style1" data-langcode="CB1228">수정</button>
											<button class="save_bt btn btn_style1 bgblue" data-langcode="CT927" style="display: none;">저장</button>
											<button class="cancel_bt btn btn_style1" data-langcode="CD755" style="display: none;">취소</button>
										</span>
									</div>
								</dd>
							</dl>
							<div class="optn_close optb_open">
								<a style="cursor:default" data-langcode="FA1482">직원 참여 옵션</a>
								<div class="option_bx" style="display: block">
									<div style="display: block">
										<label style="cursor:pointer;" for="teamSet1">
											<input type="radio" id="teamSet1" data="N" name="teamSignup">
											&nbsp;
											<span data-langcode="FA1483">관리자의 가입 승인 완료 후, 참여하도록 설정합니다.</span>
										</label>
									</div>
									<div style="display: block">
										<label style="cursor:pointer;" for="teamSet1">
											<input type="radio" id="teamSet2" data="Y" name="teamSignup">
											&nbsp;
											<span data-langcode="FA1484">특정 도메인의 이메일로 가입시, 관리자 승인 없이도 바로 참여할 수 있도록 설정합니다.</span>
										</label>
									</div>
									<div class="input_bx">
										<span id="comm_domain" style="display: none;">
											<span style="padding:0px">@</span>
											<input type="text" placeholder=">도메인 입력, 도메인 중복 등록 시 콤마로 구분" value="" maxlength="50" data-langcode="FA1485" disabled="disabled">
											<button class="edit_bt btn btn_style1" data-langcode="CB1228" style="display: inline-block;">수정</button>
											<button class="save_bt btn btn_style1 bgblue" data-langcode="CT927" style="display: none;">저장</button>
											<button class="cancel_bt btn btn_style1" data-langcode="CD755" style="display: none;">취소</button>
										</span>
									</div>
								</div>
							</div>
						</div>
						<div class="alert_box">
					        <pre>회사명이 변경되었습니다</pre>
					    </div>
					    
					    <div class="alert_box2">
					        <pre>전용 url이 변경되었습니다.</pre>
					    </div>
					    
					    
					    <div class="bgmodal_wrap layerstyle4" id="uploadLogoPopup" style="width: 450px; z-index: 11000; height: 400px; background: rgb(255, 255, 255); position: fixed; top: 50%; left: 50%; margin-top: -200px; margin-left: -225px; display: none;">
	<div class="layerstyle4_po">
		<div class="layerstyle4_title">
			<div style="position: relative; padding: 11px 0 0 16px; font-size: 16px; font-weight: normal; color: #111;
			margin-block-end: 1em; margin-inline-start: 0px; margin-inline-end: 0px;" data-langcode="CLP1098">로고 등록</div>
			<a class="btn_layerstyle4_close" id="close"><span class="blind" data-langcode="H517">팝업닫기</span></a>
		</div>
		<div class="layerstyle4_cont">
			<div class="pop_logoimg_wrap">
				<h2 class="font-Noto" style="padding:10px; text-align:center; font-size: 16px;" data-langcode="CLP1100">우리 회사 로고를 등록 하세요</h2>
				<!-- 이미지첨부전 -->
				<div class="pop_logoimg_cont" id="logoDiv" style="display: none;">
					<p>&nbsp;<!-- 이미지를 여기에 끌어다 넣으세요! --></p>
					<a data-langcode="H349">파일 첨부</a>
					<div id="logoDragAndDropDiv" style="cursor: pointer; z-index: 1; position: absolute; top: 0px; width: 100%; height: 100%;"></div>
					<!-- 드래그앤드랍 업로드 -->
					<div class="post_dnd_ly" style="display: none;">
						<div class="post_dnd_ly_po on" style="height: 109px; background-size: 25px; background-position-y: 20px;">
							<div class="status_bar" style="width: 41%;"></div>
							<div class="pctfilenm" style="padding-top: 58px;">
								<strong>41%</strong> <span data-langcode="FA1490">#콜라보모바일_Ver2.3.0_160105.pdf</span>
							</div>
						</div>
					</div>
				</div>
				<!-- //이미지첨부전 -->
				<!-- 이미지첨부후 -->
				<div class="pop_logoimg_cont2" id="file_box" style="">
					<img src="" alt="" style="transform: translateY(-50%); top: 50%; position: relative; max-height: 142px; max-width: 408px;" thum_img_path="https://flow.team/flowImg/FLOW_202306143129656_b1d7faa3-08eb-48c7-8244-3d7bca88df81.png" atch_srno="53291875">
				</div>
				<ul class="ico_edit_btn_wrap" style="list-style: none;">
					<li style="display:inline-block"><a class="ico_logoreipt" id="reUpload" data-langcode="CLP1103">다시 등록하기</a></li>
					<li><a class="ico_logodel" id="deleteLogo" style="color:red" data-langcode="CLP1104">로고 삭제</a></li>
				</ul>
				<!-- //이미지첨부후 -->
				<p class="fc_s13c585b5e" id="logoGuide" data-langcode="H190" style="display: none;">
					권장사항 - 400*100px, PNG / 최대 500KB
				</p>

			</div>
		</div>
		<div class="layerstyle_btm">
			<a class="btn_style2" id="cancel"><span data-langcode="FA1462">취소</span></a>&nbsp;&nbsp;<a class="btn_style3" id="save"><span data-langcode="FA1461">저장</span></a>
		</div>
	</div>
</div>
<div id="collabo_mod_bg_layer1" style="position: fixed; top: 0px; left: 0px; width: 100%; height: 100%; overflow: hidden; background: rgb(0, 0, 0); opacity: 0.3; z-index: 9000; display: none;"></div>
					</span>    <!-- 회사정보 끝  -->
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<span id="구성원_관리" class="left_menu" style="display: none;"> <!-- 구성원 관리 시작  -->
						<div class="titleh1_style">
							<h1 id="flow-user-title" style="display: inline-block">구성원 관리</h1>
							<a href="https://support.flow.team/hc/ko/articles/4404067811469" target="_blank" class="help-button">도움말</a>
						</div>
						
						<div id="HEAD-TAB" class="tab1_style mgt30">
							<a id="USER_USE" date="USER_USE" class="on">
								<span>정상</span> (<span id="useCnt">3</span>)
							</a>
							<a id="USER_STOP" date="USER_STOP" class="off">
								<span>이용중지</span> (<span id="stopCnt">0</span>)
							</a>
							<a id="USER_WAIT" date="USER_WAIT" class="off">
								<span>가입대기</span> (<span id="joinCnt">0</span>)
							</a>
						</div>
						
						<div id="userSearchWrap" class="tableSearchWrap mgt15">
							<div id="tableSearchArea" class="tableSearch" style="display: flex;">
								<div>
									<span>
										<select id="user_gubun_select" style="width:100px; font-size: 14px;">
											<option value="FLNM">이름</option>
											<option value="CMNM" class="js-company-info" style="display: block;">회사</option>
											<option value="DVSN_NM" class="js-company-info" style="display: block;">부서</option>
											<option value="JBCL_NM" class="js-company-info" style="display: block;">직책</option>
											<option value="EMAIL">이메일</option>
											<option value="CLPH_NO" class="js-company-info" style="display: block;">휴대폰</option>
										</select>
									</span>
									<span>
										<input type="text" id="SRCH_WORD" placeholder="검색어를 입력해주세요" style="width:220px;">
									</span>
									<span>
										<a class="btn srchbtn_style">검색</a>
									</span>
									<span class="titleh2_style_nobar mgl15" id="noDvsnUserArea" style="display: inline-block;">
										<label style="display: none;">
											<input id="noDvsnInfoUser" type="checkbox">
											<span>부서없는 인원 모아보기</span>
										</label>
									</span>
								</div>
								<div>
									<a id="UserExcel" class="btn_icodown mgr15" style="display: inline-block;">
										<span>엑셀 다운로드</span>
									</a>
									<button id="downUserListExcel" class="btn_icodown mgr15" style="display: none;">엑셀 다운로드</button>
									<a id="addUserBtn" class="btn plusbtn_style" style="display: inline-block;">
										+ <span>구성원 등록</span>
										<div id="newAddUserBtnArea" class="new-add-user-btn-area" style="display: none;">
						                    <ul>
						                        <li>
						                            <button id="newAddUserBtn" style="font-size: 13px;">구성원 개별 등록</button>
						                        </li>
						                        <li>
						                            <button id="newExcelAddUserBtn" style="font-size: 13px;">구성원 일괄 등록</button>
						                        </li>
						                    </ul>
						                </div>
									</a>
									<a id="emplBatchBtn" class="btn plusbtn_style" style="display: none;">수동 조직도/직원 연동</a>
								</div>
							</div>
							<div id="changeDvsnArea" class="tableSearchSelect" style="display: none;">
								<div>
									<p>
										<em id="checkUserCnt">0</em>
										<span>명 선택됨</span>
									</p>
								</div>
								<div>
									<button type="button" id="changeDvsnBtn" class="btn plusbtn_style">부서 변경</button>
								</div>
							</div>
						</div>
						
						<div class="btn_both"></div>
						
						<div id="USER-USE-TABLE" class="list_table mgt10 mgb15" style="display: block;"> <!-- 정상 이용자 -->
							<table>
								<thead>
									<tr>
										<th scope="col" class="js-user-check">
											<div>
												<input id="checkAllUser" type="checkbox">
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>회사</span>
												<a data="CMNM" class="sort_r"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>이름</span>
												<a data="FLNM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>부서</span>
												<a data="DVSN_NM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>직책</span>
												<a data="JBCL_NM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>이메일</span>
												<a data="EMAIL" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>휴대폰 번호</span>
												<a data="CLPH_NO" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>가입일</span>
												<a data="RGSN_DTTM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>웹 접속</span>
												<a data="P_LOGIN_DTTM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>모바일 접속</span>
												<a data="M_LOGIN_DTTM" class="sort"></a>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
											<div>
												<span>데스크탑앱 접속</span>
												<a data="D_LOGIN_DTTM" class="sort"></a>
											</div>
										</th>
										<th scope="col">
											<div>
												<span>접속장치</span>
											</div>
										</th>
										<th scope="col">
											<div>
												<span>상태</span>
											</div>
										</th>
										<th scope="col" style="cursor: pointer;">
								            <div>
								            	<span>관리자</span>
								            	<a data="MNGR_DSNC" class="sort"></a>
								            </div>
								        </th>
									</tr>
								</thead>
								<tbody id="normalUserList">
									<tr user-id="hkbk00@gmail.com" style="cursor: pointer; background-color: rgb(255, 255, 255);">
										<td class="js-user-check"><input type="checkbox"></td>
										<td class="cn">오하늘닷컴</td><td class="nm">박형근</td>
										<td class="dv"></td><td class="jb"></td>
										<td class="em">hkbk00@gmail.com</td><td class="hp"></td>
										<td>2023-06-15, 12:16</td><td>2023-06-15, 12:16</td>
										<td></td>
										<td></td>
										<td>2&nbsp;<a class="tbold_uline">[보기]</a></td>
										<td stts="Y">정상&nbsp;<a class="tbold_uline c">[이용중지]</a></td>
										<td class="ch" style="display: none;"></td>
										<td class="ih" style="display: none;"></td>
										<td class="sg" style="display: none;">-</td>
										<td mngr-dscn="F" style="font-weight: bold;"><span>Y</span>&nbsp;&nbsp;<a class="tbold_uline" style="color: red;">[삭제]</a></td>
									</tr>
									<tr user-id="brotaek@naver.com" style="cursor: pointer; background-color: rgb(255, 255, 255);">
										<td class="js-user-check"><input type="checkbox"></td>
										<td class="cn">오하늘닷컴</td><td class="nm">정택인</td>
										<td class="dv"></td><td class="jb">Marketing</td>
										<td class="em">brotaek@naver.com</td><td class="hp"></td>
										<td>2023-06-12, 15:41</td>
										<td>2023-06-15, 14:09</td>
										<td></td>
										<td></td>
										<td>2&nbsp;<a class="tbold_uline">[보기]</a></td>
										<td stts="Y">정상&nbsp;<a class="tbold_uline c">[이용중지]</a></td>
										<td class="ch" style="display: none;"></td>
										<td class="ih" style="display: none;"></td>
										<td class="sg" style="display: none;">-</td>
										<td mngr-dscn="F" style="font-weight: bold;"><span>Y</span>&nbsp;&nbsp;<a class="tbold_uline" style="color: red;">[삭제]</a></td>
									</tr>
									<tr user-id="apzkemfht@proton.me" style="cursor: pointer; background-color: rgb(255, 255, 255);">
										<td class="js-user-check"><input type="checkbox"></td>
										<td class="cn">오하늘닷컴</td><td class="nm">하늘하하늘</td><td class="dv"></td>
										<td class="jb"></td><td class="em">apzkemfht@proton.me</td>
										<td class="hp"></td><td>2023-06-14, 16:26</td>
										<td>2023-06-15, 09:14</td>
										<td></td>
										<td></td>
										<td>2&nbsp;<a class="tbold_uline">[보기]</a></td>
										<td stts="Y">정상&nbsp;<a class="tbold_uline c">[이용중지]</a></td>
										<td class="ch" style="display: none;"></td>
										<td class="ih" style="display: none;"></td>
										<td class="sg" style="display: none;">-</td>
										<td mngr-dscn="F" style="font-weight: bold;"><span>Y</span>&nbsp;&nbsp;<a class="tbold_uline" style="color: red;">[삭제]</a></td>
									</tr>
								</tbody>
							</table>
						</div>
						
						<div id="USER-STOP-TABLE" class="list_table mgt10 mgb15" style="display: none;"> <!-- 이용중지 이용자 -->
							<table cellpadding="0" cellspacing="0">
						        <thead>
						            <tr>
						            	<th scope="col" style="cursor: pointer;">
						                	<div><span>회사</span><a data="COMPANY" class="sort_r"></a></div>
						            	</th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>이름</span><a data="FLNM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span data-langcode="FA1399">부서</span><a data="DVSN_NM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>직책</span><a data="JBCL_NM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>이메일</span><a data="EMAIL" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>휴대폰 번호</span><a data="CLPH_NO" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>가입일</span><a data="RGSN_DTTM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>웹 접속</span><a data="P_LOGIN_DTTM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>모바일 접속</span><a data="M_LOGIN_DTTM" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>데스크탑앱 접속</span><a data="D_LOGIN_DTTM" class="sort"></a></div>
							            </th>
							            <th scope="col">
							                <div><span>접속장치</span></div>
							            </th>
							            <th scope="col">
							                <div><span>상태</span></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>관리자</span><a data="MNGR_DSNC" class="sort"></a></div>
							            </th>
							            <th scope="col">
							                <div><span>삭제</span></div>
							            </th>
						        	</tr>
						        </thead>
					        	<tbody id="stopUserList"><tr><td colspan="14">결과값이 존재하지 않습니다.</td></tr></tbody>
					        </table>
						</div>
						
						<div id="USER-WAIT-TABLE" class="list_table mgt10 mgb15" style="display: none;"> <!-- 가입대기 이용자 -->
							<table cellpadding="0" cellspacing="0">
						        <thead>
							        <tr>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>이름</span><a data="FLNM" class="sort_r"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>이메일</span><a data="EMAIL" class="sort"></a></div>
							            </th>
							            <th scope="col" style="cursor: pointer;">
							                <div><span>가입 요청일</span><a data="RGSN_DTTM" class="sort"></a></div>
							            </th>
							            <th scope="col">
							                <div><span>설정</span></div>
							            </th>
							        </tr>
						        </thead>
						        <tbody id="joinUserList"><tr><td colspan="4">결과값이 존재하지 않습니다.</td></tr></tbody>
						    </table>
						</div>
						
						<div id="auditorPopup" style="display: none;"><!-- 기간설정 팝업 -->
							<div class="back" style="position: fixed; top:0; right:0;bottom:0;left:0;overflow: hidden; background: rgb(0, 0, 0); opacity: 0.3; z-index: 11000;"></div>
							<div class="layer" style="width: 380px; z-index: 11000; height: auto; background: rgb(255, 255, 255); position: fixed; top: 40%; left: 50%; margin-left: -175px; border-radius: 7px;">
						        <div>
						            <div class="head" style="height: 43px; background: rgb(244, 244, 244); border-radius: 7px 7px 0px 0px;">
						                <div class="title" style="position: relative; padding: 11px 0px 0px 16px; font-size: 16px; font-weight: normal; color: rgb(17, 17, 17); margin-block-end: 1em; margin-inline-start: 0px; margin-inline-end: 0px;"> 기간 설정 </div>
						                <a class="close" style="display: block; position: absolute; top: 15px; right: 15px; width: 14px; height: 14px; background-image: url(&quot;/design2/img_rn/btn/btn_layerstyle4_close2.png?1&quot;); cursor: pointer;" id="auditorClose"><span class="close2" style="color: transparent;"></span></a>
						            </div>
						            <div class="body" style="padding: 20px;">
						                <div>
						                    <div class="center" style="text-align: center; word-break: break-all; letter-spacing: -1px;">
						                        <div class="cont">
						                            <!--@임석현  DATEPICKER -->
						                            <input type="text" id="AUDITOR_SCHD_STTG_DT" class="SCHD_STTG_DT" style="width:130px;" autocomplete="off">
						                            "~"
						                            <input type="text" id="AUDITOR_SCHD_FNSH_DT" class="SCHD_FNSH_DT" style="width:130px;" autocomplete="off">
						                        </div>
						                        <div class="btn" style="padding-top: 20px; width: 100%;">
						                            <button class="yes" id="auditorConfirm" style="width: 30%; color: rgb(255, 255, 255); border: 1px solid rgb(201, 201, 201); background-color: rgb(48, 124, 255); height: 30px; font-size: 14px; font-weight: bold; border-radius: 2px;"> 확인 </button>
						                            <button class="no" id="auditorCancel" style="width: 30%; margin-left: 10px; height: 30px; font-size: 14px; color: rgb(76, 76, 76); font-weight: bold; border: 1px solid rgb(201, 201, 201); border-radius: 2px; background-color: rgb(255, 255, 255);"> 취소 </button>
						                        </div>
						                    </div>
						                </div>
						            </div>
						        </div>
						    </div>
						</div>
						
						<div id="deviceLayer" class="bgmodal_wrap" style="position: fixed; top: 0px; left: 0px; z-index: 100; display: none;"> <!-- 접속 장치 정보  -->
							<div class="lyaer_popup_wrap" style="width:750px; max-height:530px;margin-top:-300px;margin-left:-375px;">
						        <div class="lyaer_popup_top">
						            <h1>접속 장치 정보</h1>
						            <input type="button" class="pop_close" title="닫기" style="cursor: pointer;">
						        </div>
						        <div class="lyaer_popup_cont">
						            <div class="list_table mgt15"> <!-- 리스트테이블 -->
						                <table cellpadding="0" cellspacing="0">
						                    <caption></caption>
						                    <colgroup>
						                        <col style=";">
						                        <col style="width:25%;">
						                        <col style="width:25%;">
						                    </colgroup>
						                    <thead>
							                    <tr>
							                        <th scope="col">
							                            <div>장치명</div>
							                        </th>
							                        <th scope="col">
							                            <div>최근 접속일시</div>
							                        </th>
							                        <th scope="col">
							                            <div>연결</div>
							                        </th>
							                    </tr>
						                    </thead>
						                </table>
						                <div id="deviceScroll" class="scrollbox " style="max-height: 385px;"> <!-- scroll -->
						                    <table cellpadding="0" cellspacing="0">
						                        <caption></caption>
						                        <colgroup>
						                            <col style=";">
						                            <col style="width:25%;">
						                            <col style="width:25%;">
						                        </colgroup>
						                        <tbody>
							                        <tr>
							                            <td>AndroidsamsungSMG935K</td>
							                            <td>2018.01.03 14:00</td>
							                            <td><a href="#none" class="tbold_uline">[연결 해제]</a></td>
							                        </tr>
						                        </tbody>
						                    </table>
						                </div> <!-- //scroll -->
						            </div> <!-- //리스트테이블 -->
						        </div>
						    </div>
						</div>
						
						<section id="userPopupArea" class="dimmed" style="display: none;"> <!-- 까망이 -->
							<article id="userDvsnChangePopup" class="js-user-popup article-popup popup-department-change" style="display: none;">
						        <header>
						            <h5>부서 변경</h5>
						            <button class="js-close-button button-close"></button>
						        </header>
						        <section>
						            <dl>
						                <dt>부서명</dt>
						                <dd>
						                    <div>
						                        <input id="dvsnChangeInput" class="js-dvsn-input" type="text" placeholder="부서명을 입력하세요 ">
						                        <button class="button-input-del"></button>
						                    </div>
						                    <button class="js-remove-dvsn-btn button-org-input-del" style="display: none"></button>
						                    <button class="js-open-orgchart-popup button-orgchart-popup"></button>
						                </dd>
						                <dd id="dvsnSearchResultArea" class="js-dvsn-result-area dd-search-result" style="display: none">
						                    <ul id="dvsnSearchResult" class="js-dvsn-search-result">
						                        <li>클라우드 <span class="span-search-keyword">제품</span>기획팀</li>
						                        <li>엔터프라이즈 <span class="span-search-keyword">제품</span>기획팀</li>
						                    </ul>
						                    <p class="js-no-search-dvsn-result p-search-null">
						                        <span>등록된 부서가 없습니다</span>
						                        <br>
						                        <span>[조직도 관리] 메뉴에서 부서를 먼저 등록해주세요.</span>
						                    </p>
						                </dd>
						            </dl>
						            <p>※ <span>부서정보를 일괄 업데이트 할 수 있습니다</span></p>
						        </section>
						        <footer>
						            <div class="button-wrap">
						                <button class="button-save js-submit-button">저장</button>
						                <button class="button-cancel js-close-button">취소</button>
						            </div>
						        </footer>
						    </article>
						    <article id="addUserPopup" class="article-popup popup-member-regist js-user-popup" style="display: none;">
					            <header>
					                <h5 id="addUserPopupTitle">구성원 등록</h5>
					                <button class="button-close js-close-button"></button>
					            </header>
					            <section>
					                <ol>
					                    <li>
					                        <dl>
					                            <dt>필수정보</dt>
					                            <dd>
					                                <table>
					                                    <colgroup>
					                                        <col>
					                                        <col width="335px">
					                                    </colgroup>
					                                    <tbody>
						                                    <tr>
						                                        <th>이름*</th>
						                                        <td>
						                                            <input id="addUserName" type="text" maxlength="20" placeholder="이름을 입력하세요 ">
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th>이메일*</th>
						                                        <td>
						                                            <input id="addUserEml" type="text" maxlength="50" placeholder="이메일을 입력하세요 ">
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th id="passwordTh">비밀번호*</th>
						                                        <td>
						                                            <input id="addUserPassword" type="password" maxlength="20" style="width:100%" placeholder="8자 이상, 숫자/문자/특수기호를 포함해야합니다">
						                                            <a id="userPasswordReset" class="tbold_uline reset" style="display: none;">[<span>초기화</span>]</a>
						                                        </td>
						                                    </tr>
					                                    </tbody>
					                                </table>
					                            </dd>
					                        </dl>
					                    </li>
					                    <li>
					                        <dl>
					                            <dt data-langcode="admin.company">추가정보</dt>
					                            <dd>
					                                <table>
					                                    <colgroup>
					                                        <col>
					                                        <col width="335px">
					                                    </colgroup>
					                                    <tbody>
						                                    <tr>
						                                        <th>회사명</th>
						                                        <td>
						                                            <input id="addUserCmnm" type="text" maxlength="100" disabled="" placeholder="회사명을 입력하세요 ">
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th>부서명</th>
						                                        <td>
						                                            <input id="addUserDvsnInfo" class="js-dvsn-input" dvsn_cd="" type="text" maxlength="100" placeholder="부서명을 입력하세요 ">
						                                            <button class="js-remove-dvsn-btn button-org-input-del" style="display: none"></button>
						                                            <button class="button-org-pop js-open-orgchart-popup"></button>
						                                            <div id="addUserDvsnSearchArea" class="js-dvsn-result-area div-search-result" style="display: none;">
						                                                <ul id="addUserDvsnSearchResult" class="js-dvsn-search-result" scroll-direction="0" style="display: none;"></ul>
						                                                <p class="js-no-search-dvsn-result p-search-null" style="display: none;">
						                                                    <span>등록된 부서가 없습니다</span>
						                                                    <br>
						                                                    <span>[조직도 관리] 메뉴에서 부서를 먼저 등록해주세요..</span>
						                                                </p>
						                                            </div>
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th>직책</th>
						                                        <td>
						                                            <input id="addUserJb" type="text" maxlength="100" placeholder="직책을 입력하세요 ">
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th>휴대폰 번호</th>
						                                        <td>
						                                            <input id="addUserHp" type="text" maxlength="20" placeholder="숫자와 +, -만 입력 가능합니다">
						                                        </td>
						                                    </tr>
						                                    <tr>
						                                        <th>회사 연락처</th>
						                                        <td>
						                                            <input id="addUserCmHp" type="text" maxlength="20" placeholder="숫자와 +, -만 입력 가능합니다">
						                                        </td>
						                                    </tr>
					                                    </tbody>
					                                </table>
					                                <div class="desc" style="font-size: 13px; margin: 20px 0px; line-height: 24px;">
					                                    <p data-langcode="ui.admin.label.adduser01">※ 사용자 등록 후, "이메일 주소/비밀번호" 입력하여 로그인 가능합니다.</p>
					                                    <p data-langcode="ui.admin.label.adduser02">※ 비밀번호는 웹화면 [설정&gt;비밀번호 변경] 메뉴에서 추후 변경할 수 있습니다.</p>
					                                </div>
					                            </dd>
					                        </dl>
					                    </li>
					                </ol>
					            </section>
					            <footer>
					                <div class="button-wrap">
					                    <button id="submitAddUser" class="button-save">저장</button>
					                    <button class="button-cancel js-close-button">취소</button>
					                </div>
					            </footer>
					        </article>
					        <article id="orgChartPopup" class="js-user-popup article-popup popup-department-set" style="display: none;">
						        <header>
						            <h5>
						            	<button id="returnDvsnChange" class="button-popup-back"></button>
						            	<span>부서 변경</span>
						            </h5>
						            <button class="js-close-button button-close" style="display: none;"></button>
						        </header>
						        <section>
						            <div class="search-wrap">
						                <input id="orgSearchInput" type="text" placeholder="부서명을 입력하세요 ">
						                <button id="orgSearchBtn" class="button-search">검색</button>
						            </div>
						            <div class="organization-list-wrap">
						                <div class="organization-name" id="orgPopupCompanyName"> 마드라스체크(주) </div>
						                <ul class="js-search-scroll-area">
						                    <div id="dvsnPopupTree" class="tui-tree-wrap organizationTree"></div>
						                    <li id="dvsnPopupNoneTree" class="li-organization-null" style="display: none;">
						                        <span class="null-text js-null-text">등록된 부서가 없습니다</span>
						                        <span class="null-sub-text">[조직도 관리] 메뉴에서 부서를 먼저 등록해주세요.</span>
						                    </li>
						                </ul>
						            </div>
						        </section>
						        <footer>
						            <div class="button-wrap">
						                <button class="js-submit-button button-save">저장</button>
						                <button class="js-close-button button-cancel">취소</button>
						            </div>
						        </footer>
						    </article>
						    <article class="js-user-popup article-toast-popup" style="display: none">
						        <header>
						        	비밀번호를 초기화하시겠습니까?
						        	<button class="button-close"></button>
						        </header>
						        <section>
						            <ul>
						                <li><input type="radio"><span>등록된 메일로 초기화 메일 발송</span></li>
						                <li><input type="radio"><span>비밀번호 재설정</span></li>
						            </ul>
						        </section>
						        <footer>
						            <div class="button-wrap">
						                <button class="button-cancel">취소</button>
						                <button class="button-confirm">확인</button>
						            </div>
						        </footer>
						    </article>
						</section>
						
						<div id="confirm" class="dimmed-area" tabindex="0" style="display: none;">
				            <div class="confirm-content-area">
				                <div><p>이용중지 처리하시겠습니까? </p>
				                        
				                </div>
				                
				                <div class="btn-area">
				                    <div class="cancel">취소</div>
				                    <div class="submit">확인</div>
				                </div>
				            </div>
				        </div>
				        
				        <div id="confirm2" class="dimmed-area" tabindex="0" style="display: none;">
				            <div class="confirm-content-area">
				                <div><p> 이용중지 해제하시겠습니까? </p>
				                        
				                </div>
				                
				                <div class="btn-area">
				                    <div class="cancel">취소</div>
				                    <div class="submit">확인</div>
				                </div>
				            </div>
				        </div>
						
					</span> <!-- 구성원 관리 끝  -->
					
					<!-- 구성원초대 시작 -->
					<span id="구성원_초대" class="left_menu" style="display:none;">
					<!-- 대타이틀 -->
					<div class="titleh1_style title-return-button">
						<button id="returnUserView" class="return_back" style="display: none;"></button>
						<h1 id="flow-invite-title">구성원 초대</h1>
					</div>
					
					
					
					
					
					
					<div id="INVITE_EMAIL_UI" class="payment_cont topline_none">
						<div class="infotxt1_style mgb20">
							<ul>
								<li>· <span data-langcode="ADMININVITE016">전용 URL을 통해 초대받은 직원은 관리자가 설정한 참여 옵션에 따라서 이용이 가능합니다.</span></li>
								<li><span data-langcode="ADMININVITE017">(관리자 설정 -&gt; 회사 정보 -&gt; 전용 URL - 직원 참여 옵션)</span></li>
								<li>· <span data-langcode="ADMININVITE018">이메일 초대를 통해 이메일을 수신한 직원은 직접 계정 가입 후 바로 이용 가능합니다.</span></li>
							</ul>
							<a href="https://support.flow.team/hc/ko/articles/4403734075917" target="_blank" rel="noopener noreferrer" class="help-view-btn" data-langcode="ADMININVITE007">도움말</a>
						</div>
						<dl>
							<dt data-langcode="ADMININVITE019">전용 URL</dt>
							<dd>
								<p class="mgb15" data-langcode="ADMININVITE020">전용 URL 주소를 전달하여 회사 직원들을 참여시킬 수 있습니다.</p>
								<div class="input_bx"><span>
										<input id="url_bx" type="text" placeholder="" value="https://회사협업툴url.with" disabled="" style="width:320px;font-weight:bold;color:#307cff;">
										<button class="btn_copy" title="Copy" type="button" value="https://5sky.with/corpsignup.act" onclick="moment();"></button>
									<!-- <button type="button" class="btn btn_style1 bgblue" title="저장">저장</button>
					            <button type="button" class="btn btn_style1" title="취소">취소</button> -->
									</span></div>
							</dd>
							<dt data-langcode="ADMININVITE026">이메일 초대</dt>
							<dd>
								<p class="mgb15" data-langcode="ADMININVITE027">직원들의 이메일 주소를 입력하여 바로 초대할 수 있습니다.</p>
								<ul class="ivtemail">
									
									<li><input class="ivt_input_bx" type="text" placeholder="example@with" maxlength="100" style="color: red;"><img style="margin-left:20px;" src=""></li>
									<li><input class="ivt_input_bx" type="text" placeholder="example@with" maxlength="100"><img style="margin-left:20px;" src=""></li>
									<li><input class="ivt_input_bx" type="text" placeholder="example@with" maxlength="100"><img style="margin-left:20px;" src=""></li>
									<li><input class="ivt_input_bx" type="text" placeholder="example@with" maxlength="100"><img style="margin-left:20px;" src=""></li>
									<li><input class="ivt_input_bx" type="text" placeholder="example@with" maxlength="100"><img style="margin-left:20px;" src=""></li>
									
								</ul>
								<button id="ivt_submit" class="btn btn_style1 bgblue" data-langcode="ADMININVITE028">전송</button>
							</dd>
						</dl>
					</div><!-- //이메일목록 -->
					<div id="invite-error-box" class="errorbox" style="display:none;">
						<ul></ul>
					</div>

                </span>
					
					<!-- 구성원초대 끝 -->
					
					<!-- 조직도 관리 start -->
					<span id="조직도_관리" class="left_menu" style="display:none;">
						<div class="titleh1_style">
							<h1>조직도 관리</h1>
						</div>
						<div class="payment_cont topline_none">
							<div class="infotxt1_style mgb20">
								<strong>가이드</strong>
								<ul>
									<li>
										· 
										<span>조직도 관리 기능 사용여부를 설정할 수 있습니다.</span>
									</li>
									<li>
										· 
										<span>부서 정보는 1개씩 추가하거나 엑셀을 통한 일괄 등록도 가능합니다.</span>
									</li>
									<li>
										· 
										<span>부서 정보는 최대 8 Depth까지 구성할 수 있습니다.</span>
									</li>
								</ul>
								<a href="사용자매뉴얼.html" target="_blank" class="help-view-btn">도움말</a>
							</div>
						</div>
						<div class="adminTextWrap">
							<p class="adminText">
								<span>조직도 기능이 </span>
								<em id="orgChartUseText">비활성</em>
								<span> 상태로 설정되어 있습니다.</span>
							</p>
							<div class="switchLabel">
								<label class="switch-35">
									<input type="checkbox" id="activeOrgCheckbox">
									<span class="btn-switch" id="activeOrgButton">
										<span></span>
									</span>
								</label>
							</div>
						</div>
						<div id="orgManagementArea" class="organizationChartWrap mgt20">
							<div class="organizationSearch">
								<div>
<!-- 									<input type="text" id="dvsnSearchWord" placeholder="검색어를 입력해주세요" style="width:240px;"> -->
<!-- 									<button type="button" id="dvsnSearchBtn" class="btn srchbtn_style btnSearch">검색</button> -->
								</div>
								<div>
									<button type="button" id="excelRegistration" class="btn_style1 bgblue2" disabled>부서 일괄 등록</button>
								</div>
							</div>
							<div class="organizationManage mgt10">
								<div class="top">
									<strong>부서명</strong>
								</div>
								<div class="middle">
									<div class="organizationName">
										<strong id="dvsnUseInttId">스카이몰25(skymall25)</strong>
									</div>
									<ul class="organizationList">
										<li>
						                    <div id="orgChartTree" class="tui-tree-wrap organizationTree" style="display: none;">
							                    <ul class="tui-tree tui-tree-root">
							                    	
							                    </ul>
							                    <span class="tui-tree-drop" style="position: absolute; display: none;"></span>
							                    <div class="tui-tree-line" style="position: absolute;display: none;"></div>
						                    </div>
						                </li>
										
										<li id="orgChartNoneData" class="organizationInfoText" style="display:none;">
											<p class="adminText">
												<span>부서 등록이 되어 있지 않습니다.</span>
											</p>
										</li>
									</ul>
								</div>
									<script>
										
									</script>
								<div class="bottom">
									<button id="treeAddBtn" class="btn srchbtn_style">추가</button>
									<button id="treeEditBtn" class="btn srchbtn_style">수정</button>
									<button id="treeRemoveBtn" class="btn srchbtn_style">삭제</button>
									<button id="removeAllTreeBtn" class="btn srchbtn_style" onclick="openPop();" style="display: none;"></button>
								</div>
								<div id="disabledOrgArea" class="organizationInfoDimm">
									<p class="adminText">
										<span>
											조직도 관리 기능 활성화 후, 이용할 수 있습니다.
											<br/>
										</span>
										<a href="사용자매뉴얼.html" target="_blank" class="admin-link">
											조직도 관리 기능 알아보기
										</a>
									</p>
								</div>
							</div>
						</div>
					</span>
					<!-- 조직도관리 end -->
					<span id="부서_일괄_등록" class="left_menu" style="display:none;">
						<div class="titleh1_style title-return-button">
						    <button id="returnOrgMainBtn" class="return_back"></button>
						    <h1 id="orgRegisterTitle" data-langcode="ORG008">부서 일괄 등록</h1>
						</div>
						<div id="INVITE_EXCEL_UI">
						    <div class="infotxt1_style mgt20">
						        <ul>
						            <li>· <span data-langcode="ORG023">1회 최대 200개의 조직을 등록할 수 있습니다.</span></li>
						            <li>· <span data-langcode="ORG24">"등록 불가능한 행 모아보기" 체크박스 체크 시, 관련 행만 모아볼 수 있습니다</span></li>
						            <li>· <span data-langcode="ORG025">등록 완료 후, 조회 페이지에서 확인 및 편집 가능합니다.</span>
						            </li>
						        </ul>
						        
						            <a href="사용자매뉴얼.html" target="_blank" rel="noopener noreferrer" class="help-view-btn" data-langcode="ADMININVITE007">도움말</a>
						        
						    </div>
						    <!-- 엑셀 밀어넣기 API -->
						    <div class="payment_cont topline_none">
						        <dl>
						            <dd style="padding-bottom:15px">
						                <div id="EMPL_EXCEL_UPLOAD">
						                    <input id="pwd" type="text" value="flow123~!" style="display: none;">
						                    <div>
						                        <input id="fileInputText" type="text" placeholder="xlsx 파일만 업로드 가능합니다." readonly="" style="cursor:pointer;border: 1px solid #e6e6e6;" data-langcode="ADMININVITE008">
						                        <input type="file" style="display:none;" id="excelFileInput" accept="application/vnd.ms-excel,vnd.ms-excel.sheet.macroEnabled.12,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
						                        <button id="addDvsnFile" class="upload btn btn_style1 bgblue" data-langcode="ADMININVITE009">파일 등록</button>
						                        <script>
													  var fileInput = document.getElementById("excelFileInput");
													  var fileInputText = document.getElementById("fileInputText");
													
													  fileInput.addEventListener("change", function() {
													    if (fileInput.files.length > 0) {
													      fileInputText.value = fileInput.files[0].name;
													    } else {
													      fileInputText.value = "";
													    }
													  });
													  document.getElementById("addDvsnFile").addEventListener("click", function() {
													    fileInput.click();
													  });
												</script>
						                        <a class="btn btn_style1 invite-excel-download" id="dvsnTemplateDown" data-langcode="ADMININVITE010" href="Images/with_logo.png" download>엑셀 양식 다운로드</a>
						                    </div>
						                    <p class="info mgt5" data-langcode="ADMININVITE021">※ 파일등록 시, 해당 엑셀 표로 아래 표가 초기화됩니다.</p>
						                    <span class="loader" style="display:none; margin: 10px;"><img src="/design2/img/ajax-loader.gif"></span>
						                </div>
						            </dd>
						        </dl>
						    </div>
						    <!-- 엑셀 밀어넣기 API -->
						    <div class="list_table mgt10 mgb15">
						        <div class="excel-menu-area">
						            <div id="count-div" class="excel-count">
						                <span><strong><span data-langcode="ADMININVITE022">전체 :</span><span id="all-count"> 0</span><span data-langcode="ADMININVITE023"></span></strong></span>
						                <span>(<span data-langcode="ADMININVITE024">등록 가능 : </span>
						                    <span id="posible-count">0</span>,
											<span data-langcode="ADMININVITE025">등록 불가 : </span>
						                    <span style="color:red;">
												<span id="err-count">0</span></span></span>)
						                
						                <label class="impossible-line-view"><input id="errorRowCheckBox" type="checkbox"> <span data-langcode="ADMININVITE011">등록 불가능한 행 모아보기</span></label>
						            </div>
						            <div class="excel-menu">
						                <button id="addDvsnCell" class="btn btn_style1" data-langcode="ADMININVITE012">행 추가</button>
						                <button id="removeDvsnCell" class="btn btn_style1" data-langcode="H381">삭제</button>
						                <button id="submitDvsnExcel" class="btn btn_style1 bgblue" data-langcode="ADMININVITE013">등록</button>
						            </div>
						        </div>
						        <table id="excel-list-header" cellpadding="0" cellspacing="0">
						            <caption></caption>
						            <colgroup>
						                <col>
						                <col>
						                <col>
						                <col>
						            </colgroup>
						            <thead>
						            <tr id="excel-add-th" class="dvsn-excel-tr">
						                <th class="dvsn-excel-check-th" scope="col">
						                    <div><input id="dvsnThCheckBox" type="checkbox" data-checked="false"></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG020">부서코드</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="CB1244">부서명</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG021">상위부서코드</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG022">순서</span></div>
						                </th>
						            </tr>
						            </thead>
						        </table>
						        <!-- scroll -->
						        <div id="excel-scroll" class="scrollbox" style="">
						            <table cellpadding="0" cellspacing="0">
						                <caption></caption>
						                <colgroup>
						                </colgroup>
						                <tbody id="excelDataList"></tbody>
						            </table>
						        </div>
						        <!-- //scroll -->
						    </div>
						</div>
						

                </span>
                <!-- 조직도관리 end -->
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					
					<!-- 프로젝트 관리 시작  -->
					<span id="프로젝트_관리" class="left_menu" style="display: none;"> 
						<div class="titleh1_style">
							<div>
								<h1 id="flow-proj-manage-title">프로젝트 관리</h1>
							</div>
						</div>
						<!-- //대타이틀 -->
						
						<!-- tab1_style -->
						<div id="HEAD-TAB" class="tab1_style mgt30">
							<a id="ENABLE_PROJECT_TAB" data="ENABLE_PROJECT" class="on" data-langcode="FA1744">프로젝트</a>
							<a id="DISABLE_PROJECT_TAB" data="DISABLE_PROJECT" class="off" data-langcode="" style="display: none;">이용중지</a>
						</div>
						<!-- //tab1_style -->
						
						<!-- 검색테이블 -->
						<div id="PROJECT_SEARCH" class="titleh2_style" style="margin-top:15px; margin-bottom:15px;">
							<table cellpadding="0" cellspacing="0">
								<colgroup>
						
						
						
									<col style="width:20%;">
									<col style="width:20%;">
									<col style="width:35%;">
									<col>
									<col>
								</colgroup>
								<tbody><tr>
									<td colspan="4">
										<input id="project_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:280px;" data-langcode="FA1441">
										<select style="display: none;">
											<option data-langcode="FA1605" data="activity-date" value="ACTIVE">최근 활동일</option>
											<option data-langcode="" data="write-date" value="WRITE" style="display: none;">게시물 등록일</option>
										</select>
										<span style="padding-right: 11px;">최근 활동일 </span>
										<input type="text" id="USE_SCHD_STTG_DT" style="width:130px;" autocomplete="off">
										<input type="text" id="USE_SCHD_FNSH_DT" style="width:130px;" autocomplete="off">
										<label style="display: none;"><input id="isProjectActive" type="checkbox">활성화 여부</label>
										<a id="PROJECT_SRCH_BTN" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>
										<a style="background-color: #d03737;color:white;display: none; margin-left: 5px" id="delete_BTN" class="btn mgr15 srchbtn_style" data-langcode="">삭제</a>
									</td>
						
								</tr>
							</tbody></table>
							<div class="right">
								<a id="disable_BTN" class="btn mgr15 srchbtn_style" style="display: none;" data-langcode="">자동 이용중지 설정</a>
								 <button id="PROJECTExcel" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
							</div>
						</div>
						<!-- //검색테이블 -->
						
						<!-- 리스트테이블 (enable) -->
						<div id="ENABLE_PROJECT_TABLE" class="list_table mgt10 mgb15">
							<table cellpadding="0" cellspacing="0">
								<caption></caption>
								<colgroup>
									
									<col style="width:20%">
									
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
								</colgroup>
								<thead>
									<tr>
										<th scope="col" style="display: none;"><div><span data-langcode="">프로젝트 번호</span><a data="PROJ_NUM"></a></div></th>
										<th scope="col"><div><span data-langcode="FL558">프로젝트명</span><a data="TTL"></a></div></th>
										
										<th scope="col"><div><span data-langcode="H420">관리자</span><a data="ADMIN"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1602">참여자</span><a data="JOIN_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1602">임직원</span><a data="JOIN_INNER_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1438">게시물</span><a data="PROJECT_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1439">댓글</span><a data="REMARK_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1433">채팅</span><a data="CHAT_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1435">일정</span><a data="SCHD_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1437">업무</span><a data="TASK_CNT"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1605">최근 활동일</span><a data="EDTR_DTTM"></a></div></th>
										<th scope="col"><div><span data-langcode="FA1760">개설일</span><a data="RGSN_DTTM"></a></div></th>
										<th scope="col" id="disableTable" style="display: none"><div><span data-langcode="">이용중지 예정일 (D-day)</span><a data="STOP_DTTM"></a></div></th>
									</tr>
								</thead>
							</table>
						
						
							<!-- scroll -->
							<div id="useStatPrjScroll" class="scrollbox">
								<table cellpadding="0" cellspacing="0">
									<caption></caption>
									<colgroup>
										
										<col style="width:20%">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
									</colgroup>
									<tbody></tbody>
								</table>
							</div>
							<!-- //scroll -->
						</div>
						
						<!-- 리스트테이블 (disable) -->
						<div id="DISABLE_PROJECT_TABLE" class="list_table mgt10 mgb15" style="display: none">
							<table id="disableProjectTable" cellpadding="0" cellspacing="0">
								<caption></caption>
								<colgroup>
									<col style="width:50px;">
									<col style="width:20%">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
									<col style="">
								</colgroup>
								<thead>
								<tr>
									<th scope="col"><div><span data-langcode=""> </span><a data=""></a></div></th>
									<th scope="col"><div><span data-langcode="FL558">프로젝트</span><a data="TTL"></a></div></th>
									<th scope="col"><div><span data-langcode="H420">관리자</span><a data="ADMIN"></a></div></th>
									<th scope="col"><div><span data-langcode="FA1602">전체 참여자</span><a data="JOIN_CNT"></a></div></th>
									<th scope="col"><div><span data-langcode="FA1605">최근 활동일</span><a data="EDTR_DTTM"></a></div></th>
									<th scope="col"><div><span data-langcode="FA1760">개설일</span><a data="RGSN_DTTM"></a></div></th>
									<th scope="col"><div><span data-langcode="">이용중지일</span><a data="STOP_DTTM"></a></div></th>
									<th scope="col"><div><span data-langcode="">비고</span><a data="RELATIVE_HEIGHT"></a></div></th>
								</tr>
								</thead>
							</table>
						
						
							<!-- scroll -->
							<div id="disableUseStatPrjScroll" class="scrollbox">
								<table id="disableProjectTableDetail" cellpadding="0" cellspacing="0">
									<caption></caption>
									<colgroup>
										
										<col style="width:50px;">
										<col style="width:20%">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
										<col style="">
										<col class="ifRelease" style="">
									</colgroup>
									<tbody>
									<tr>
										<td></td>
										<td>웹 최신 디자인 트랜드 공유</td>
										<td>1</td>
										<td>2</td>
										<td>3</td>
										<td>4<s td="">
										</s></td><td>5</td>
										<td>6</td>
										<td>[해제]</td>
									</tr>
									</tbody>
								</table>
							</div>
							<!-- //scroll -->
						</div>
						
						
						<!-- 누르면 나오는 모달창 -->
						
						<div id="addProjLayer2" class="bgmodal_wrap" style="display:none;">
						
							<div class="lyaer_popup_wrap" style="width:900px;margin-top:-370px;margin-left:-450px;">
								<div class="lyaer_popup_top">
									<h1><span data-langcode="FA1834">프로젝트 정보</span><input style="cursor:pointer" type="button" class="pop_close" title="닫기"></h1>
								</div>
								<div class="lyaer_popup_cont">
									<div class="srch_table mgt10">
										<table cellpadding="0" cellspacing="0" class="htlowtype">
											<colgroup>
											<col style="width:150px;"><col>
											</colgroup>
											<tbody><tr>
												<th scope="row" data-langcode="FL567">프로젝트명</th>
												<td><input name="proj_name" type="text" placeholder="프로젝트명을 입력하세요" style="width:98.5%;" maxlength="100" data-langcode="FA1441"></td>
											</tr>
						                    <tr>
						                        <th scope="row" data-langcode="H420">프로젝트 멤버</th>
						                        <td>
						                            <a id="mngrAdd2" style="cursor:pointer; display: none; width: 50px;" class="btn btn_style1_s" data-langcode="FA1443">추가</a>
						                            <input name="employee_name" type="text" placeholder="프로젝트회원을 입력하세요 " style="width:98.5%;" maxlength="100" data-langcode="FA1441">
						                            <span id="mngrAlert2" style="color:red"></span>
						                            <span class="ngrAlert" style="color:red; display:none;">프로젝트명은 3글자 이상 입력해주세요</span>
						                        </td>
						                    </tr>
						
											<tr>
											 	<td colspan="2">
													<!-- 리스트테이블 -->
													<div id="mngr_list_table2" class="list_table">
														<table cellpadding="0" cellspacing="0">
															<caption></caption>
															<colgroup>
															<col style="width:10%;">
															<col style="width:17%;">
															<col style="width:27%;">
															<!--<col style="width:15%;"> -->
															<col style="width:15%;">
															<col style=";">
															<col style="width:13%;">
															<col class="add_exp">
															</colgroup>
															<thead>
																<tr>
																	<th scope="col"><div data-langcode="FA1444">사용자명</div></th>
																	<th scope="col"><div data-langcode="FL561">이메일</div></th>
																	<!-- <th scope="col"><div>회사</div></th> -->
																	<th scope="col"><div data-langcode="FA1399">부서</div></th>
																	<th scope="col"><div data-langcode="FA1444">직책</div></th>
																	<th scope="col"><div data-langcode="H333">가입일</div></th>
																	<th scope="col"><div data-langcode="H358">휴대폰 번호</div></th>
																	<th scope="col" class="add_exp"><div data-langcode="FA1449">관리자</div></th>
																</tr>
															</thead>
														</table>
														<!-- scroll -->
														<div id="projUserDiv" class="scrollbox" style="max-height: 195px; border-bottom:1px solid #c5c6cb;">
															<table cellpadding="0" cellspacing="0">
																<caption></caption>
																<colgroup>
																	<col style="width:10%;">
																	<col style="width:17%;">
																	<col style="width:27%;">
																	<!--<col style="width:15%;"> -->
																	<col style="width:15%;">
																	<col style=";">
																	<col style="width:13%;">
																	<col class="add_exp">
																</colgroup>
																<tbody id="mngr_tbody2">
																	<tr><td name="username">정택인</td><td><span class="user_ids" data-userid="brotaek@naver.com">brotaek@naver.com</span></td><td></td><td></td><td></td><td></td><td>&nbsp;<a class="out_bt tbold_uline admin-release" value="destory">관리자[해제]</a></td></tr>
																	<tr><td name="username">하늘하하늘</td><td><span class="user_ids" data-userid="apzkemfht@proton.me">apzkemfht@proton.me</span></td><td></td><td></td><td></td><td></td><td>&nbsp;<a class="out_bt tbold_uline admin-selecte" value="select">정상[선택]</a></td></tr>
																</tbody>
															</table>
														</div>
														<!-- //scroll -->
													</div>
													<!-- //리스트테이블 -->
												</td>
											</tr>
											<!--
											<tr class="edit_text">
												<th  scope="row">활동요약</th>
												<td>참여자수 : 30 / 게시물 : 100 / 댓글 : 40 / 파일용량(MB) : 300 / 최근활동일 : 2018.05.04</td>
											</tr>
											<tr class="edit_text">
												<th  scope="row">생성정보</th>
												<td>2018.01.03 / 이학준 (desk383)</td>
											</tr>
											 -->
											<tr id="prj_mngr_wr_yn_area" style="">
											    <th scope="row" data-langcode="CM1330">글 작성 권한</th>
												<td>
											        <div class="radiobox">
														<label class="on"><input type="radio" name="prj_mngr_wr_yn" value="N" checked="checked">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="prj_mngr_wr_yn" value="Y">&nbsp;<span id="prj_mngr_wr_text" style="cursor:pointer" data-langcode="CM1332">관리자만 글 작성 가능</span></label>
													</div>
											    </td>
											</tr>
											<tr id="prj_mngr_wr_cm_yn_area">
												<th scope="row" data-langcode="CM1330">댓글 작성</th>
												<td>
													<div class="radiobox">
														<label class="on"><input type="radio" name="prj_mngr_wr_cm_yn" value="N" checked="checked">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="prj_mngr_wr_cm_yn" value="Y">&nbsp;<span style="cursor:pointer" data-langcode="CM1332">관리자만</span></label>
													</div>
												</td>
											</tr>
											
											<tr>
											    <th scope="row" data-langcode="CM1333">글 조회</th>
												<td>
											        <div class="radiobox">
														<label class="on"><input type="radio" name="omprj_srch_auth_yn" value="N" checked="checked">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="omprj_srch_auth_yn" value="Y">&nbsp;<span style="cursor:pointer" data-langcode="FA1455">관리자 + 글 작성 본인만</span></label>
														<span id="mngrAlert2" style="color:red" data-langcode="FA1456">※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span>
													</div>
											    </td>
											</tr>
											<tr>
											    <th scope="row" data-langcode="CM1338">파일 다운로드</th>
												<td>
											        <div class="radiobox">
														<label class="on"><input type="radio" name="omprj_prj_auth" value="N" checked="checked">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="omprj_prj_auth" value="Y">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">관리자 + 글 작성 본인만  <span style="color: red">※ 다운로드 및 열람 모두 제한됩니다(첨부 파일, 이미지)</span></span></label>
													</div>
											    </td>
											</tr>
											<tr id="writeEditAuthTypeProj" style="">
												<th scope="row" data-langcode="">글 수정</th>
												<td>
													<div class="radiobox">
														<label class="on"><input type="radio" name="riteEditAuth" value="MNGRMYSELF" checked="checked">&nbsp;<span style="cursor:pointer" data-langcode="">관리자 + 글 작성 본인만</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="riteEditAuth" value="MYSELF">&nbsp;<span style="cursor:pointer" data-langcode="">글 작성 본인만</span></label>
													</div>
												</td>
											</tr>

											<tr id="postModDelAuthTypeProj" style="display: none">
												<th scope="row" data-langcode="">게시물 수정/삭제 방지</th>
												<td>
													<div class="radiobox">
														<label class="on"><input type="radio" name="postModDelAuth" value="Y" checked="" disabled="">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="postModDelAuth" value="N" disabled="">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
														<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
													</div>
												</td>
											</tr>
											<tr id="replyModDelAuthTypeProj" style="display: none">
												<th scope="row" data-langcode="">댓글 수정/삭제 방지</th>
												<td>
													<div class="radiobox">
														<label class="on"><input type="radio" name="replyModDelAuth" value="Y" checked="" disabled="">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
														<label class="on"><input type="radio" name="replyModDelAuth" value="N" disabled="">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
														<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
													</div>
												</td>
											</tr>
						
						
											<tr id="anoymousProj" style="display:none">
												<th scope="row" data-langcode="">익명방 여부</th>
												<td>
													<div class="">
														<label><input name="anoymous" type="checkbox"><span>  <span style="color: red">※익명방 여부 설정이후 변경 불가</span></span></label>
													</div>
												</td>
											</tr>
											<tr id="specialProjectSetting" style="display: none;">
												<th scope="row" data-langcode="">특수 기능</th>
												<td>
													<div class="">
														<label class="on"><input type="checkbox" name="comprj_prj_blind_room">&nbsp;<span style="cursor:pointer" data-langcode="">블라인드방 여부</span></label>
													</div>
												</td>
											</tr>
											<tr id="dbOfficialAppoint" style="display: none;">
											    <th scope="row" data-langcode="">공식 프로젝트 지정</th>
												<td>
											        <div class="radiobox">
														<label class="on"><input type="checkbox" name="officail_proj_check"></label>&nbsp;&nbsp;
													</div>
											    </td>
											</tr>
											<tr id="projectEnd" class="border-top" style="display: none;">
												<th scope="row" data-langcode="">프로젝트 상태</th>
												<td>
													<div class="before-terminate-case">
														<button class="button-project-terminate">종료하기</button>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span>
													</div>
													<div class="after-terminate-case">
														<span style="font-weight: bold;">종료된 프로젝트</span>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span>
													</div>
												</td>
											</tr>
										</tbody></table>
									</div>
									<!-- // -->
						
									<div class="t_center mgt15 btn_wrap">
										<div class="left"><a id="del_proj2" style="cursor: pointer;" class="btn btn_popstyle2 bgred" data-langcode="H381">삭제</a></div>
										<div class="left"><a id="stop_project" style="cursor: pointer; display: none;" class="btn btn_popstyle2 bgred" data-langcode="">이용중지</a></div>
										<a id="save-or-edit2" style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="CT927">저장</a>
										<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
									</div>
								</div>
							</div>
							
							
<!-- 							<div class="alert_box" style="display: none;"> -->
<!-- 					        <pre>관리자 인원은 최소 한 명 이상 필요합니다.</pre> -->
<!-- 					    	</div> -->
						
						
						
						
							<!-- 관리자페이지 -->
							<div id="proj_mngr_layer2" class="layer_popup_wrap" style="display:none; z-index:1001; width: 570px; min-height: 180px;
							       padding-bottom: 20px; margin-top: -300px; margin-left: -285px;">
								<div class="layer_popup_top">
								<h1 data-langcode="AA0107">관리자 선택</h1>
									<a style="cursor:pointer" class="pop_close"><img src="https://flow.team/js/admin/assets/img/btn_popclose.gif" alt="닫기"></a>
						
									<div class="srch_table mgt20">
										<table cellpadding="0" cellspacing="0">
											<colgroup>
												<col style="width:15%">
												<col style="width:35%">
												<col style="width:60%">
											</colgroup>
											<tbody>
											<tr>
												<td>
													<select id="comm_user_catg2">
														<option data-langcode="H331">이름</option>
														<option data-langcode="FL561">아이디</option>
													</select>
												</td>
												<td><input id="comm_user_srch_word2" type="text" style=""></td>
												<td><a style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
											</tr>
											</tbody>
										</table>
									</div>
								</div>
						
								<div class="layer_popup_cont">
									<div class="list_table mgt20 mgb15">
										<table cellpadding="0" cellspacing="0">
											<caption></caption>
											<colgroup>
											<col style="">
											<col style="">
											<col style="width:20%">
											</colgroup>
											<thead>
												<tr>
													<th scope="col"><div><span data-langcode="H331">이름</span><a data="TTL" style="cursor:pointer" class="sort"></a></div></th>
													<th scope="col"><div><span data-langcode="FL561">아이디</span><a data="SENDIENCE_CNT" style="cursor:pointer" class="sort"></a></div></th>
													<th scope="col"><div><span data-langcode="CLP1003">선택</span><a data="COMMT_CNT" style="cursor:pointer" class="sort"></a></div></th>
												</tr>
											</thead>
										</table>
										<!-- scroll -->
										<div id="mngr_scroll2" class="scrollbox" style="height:200px">
											<table cellpadding="0" cellspacing="0">
												<caption></caption>
												<colgroup>
												<col style="">
												<col style="">
												<col style="width:20%">
												</colgroup>
												<tbody id="comm_user_tbody2">
													<tr>
														<td>웹 최신 디자인 트랜드 공유</td>
														<td>130</td>
														<td><a href="#" class="tbold_uline">[선택]</a></td>
													</tr>
												</tbody>
											</table>
										</div>
										<!-- //scroll -->
									</div>
									<!-- //리스트테이블 -->
								</div>
						
								<div class="t_center mgt15 btn_wrap">
									<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
									<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
								</div>
						
							</div>
							<div class="bgmodal" style="display:none;"></div>
						
						
						
						
						
						
							<!-- 기업추가 페이지 -->
							<div id="commListLayer2" class="bgmodal_wrap" style="display:none;">
						
								<div class="lyaer_popup_wrap" style="width:350px;height:330px;margin-top:-200px;margin-left:-375px;">
									<input type="button" class="pop_close" title="닫기">
									<div class="lyaer_popup_top">
										<h1 data-langcode="FA1470">접속 장치 정보</h1>
									</div>
									<div class="lyaer_popup_cont">
										<!-- 리스트테이블 -->
										<div class="list_table mgt15">
											<table cellpadding="0" cellspacing="0">
												<caption></caption>
												<colgroup>
													<col style="width:15%;">
													<col>
												</colgroup>
												<thead>
													<tr>
														<th scope="col"><div data-langcode="CLP1003">선택</div></th>
														<th scope="col"><div data-langcode="H330">회사명</div></th>
													</tr>
												</thead>
											</table>
											<!-- scroll -->
											<div class="scrollbox mCustomScrollbar _mCS_1 mCS_no_scrollbar" style="max-height: 185px;"><div id="mCSB_1" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_1_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
												<table cellpadding="0" cellspacing="0">
													<caption></caption>
													<colgroup>
														<col style="width:15%;">
														<col>
													</colgroup>
													<tbody>
														<tr>
															<td>111</td>
															<td>웹케시</td>
														</tr>
													</tbody>
												</table>
											</div><div id="mCSB_1_scrollbar_vertical" class="mCSB_scrollTools mCSB_1_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_1_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
											<!-- //scroll -->
										</div>
										<!-- //리스트테이블 -->
						
										<div class="t_center mgt15 btn_wrap">
											<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
											<a style="cursor:pointer" class="btn btn_popstyle1" data-langcode="CD755">취소</a>
										</div>
									</div>
								</div>
							</div>
						
						</div>
						<div id="disableLayer" class="bgmodal_wrap" style="display:none;">
							<div class="lyaer_popup_wrap" style="width:900px;margin-top:-370px;margin-left:-450px;">
								<div class="lyaer_popup_top">
									<h1><span data-langcode="FA1834">자동 이용중지 설정</span>
										<input style="cursor:pointer" id="disableClose" type="button" class="pop_close" title="닫기"></h1>
								</div>
								<div class="lyaer_popup_cont">
									<p style="color:#3A75B6;margin-top: 5px;">자정(00:00)마다 최근 활동일을 기준으로 하여 설정한 기간이 지난 프로젝트는 이용중지 처리됩니다.</p>
									<p style="font-size: 4px;">이용중지된 프로젝트는 이용자의 화면에서 사라집니다.(프로젝트 리스트/전체업무/간트차트/파일함/프로젝트 채팅방/알림/북마크/나를 언급/내 게시물/임시저장)</p>
									<div style="margin-top:30px;"><span>자동 이용중지</span>
										<label class="switch-35" for="disableSetting">
											<input type="checkbox" id="disableSetting" disabled="">
											<span id="disableBtnType" class="btn-switch">
										<span></span>
									</span>
										</label>
										<span id="searchSpan" style="width: 300px;margin-left : 20px; display: none">
											<select id="searchOption">
											<option class="search-option-select" data="activity-date" value="30">30일</option>
											<option class="search-option-select" data="activity-date" value="90">90일</option>
											<option class="search-option-select" data="activity-date" value="180">180일</option>
						                    <option class="search-option-select" data="activity-date" value="365">365일(1년)</option>
						                    <option class="search-option-select" data="activity-date" value="730">730일(2년)</option>
						                    <option class="search-option-select" data="activity-date" value="1095">1,095일(3년)</option>
										</select></span>
									</div>
									<div class="upload-button-area">
										<button style="width: 125px;margin-top : 30px;" id="disableEditBtn" type="submit" class="btn_style1 bgblue">수정</button>
										<button id="disableSaveBtn" type="reset" class="btn_style1 mgr10 bgblue" style="display: none;width: 65px;margin-top : 30px;">저장</button>
										<button id="disableCancleBtn" type="reset" class="btn_style1" style="display: none;width: 65px;margin-top : 30px;">취소</button>
									</div>
								</div>
							</div>
						</div>
						
						<div id="projectInfoWhenStopped" class="bgmodal_wrap" style="display:none;">
							<div class="lyaer_popup_wrap" style="width:900px;margin-top:-370px;margin-left:-450px;">
								<div class="lyaer_popup_top">
									<h1><span data-langcode="FA1834">프로젝트 정보</span><input style="cursor:pointer" type="button" class="pop_close" title="닫기"></h1>
								</div>
								<div class="lyaer_popup_cont">
									<div class="srch_table mgt10">
										<table cellpadding="0" cellspacing="0" class="htlowtype">
											<colgroup>
												<col style="width:50px;"><col>
											</colgroup>
											<tbody><tr>
												<th scope="row" data-langcode="FL567">프로젝트명</th>
												<td><p name="proj_name_Ondisable" type="text" maxlength="100" data-langcode=""></p></td>
											</tr>
											<tr>
												<td colspan="2">
													<!-- 리스트테이블 -->
													<div id="mngr_list_table_Ondisable" class="list_table">
														<table cellpadding="0" cellspacing="0">
															<caption></caption>
															<colgroup>
																<col style="width:17%;">
																<col style="width:27%;">
																<col style="width:15%;">
																<col style=";">
																<col style="width:13%;">
																<col style="">
															</colgroup>
															<thead>
															<tr>
																<th scope="col"><div data-langcode="FA1444">참여자명</div></th>
																<th scope="col"><div data-langcode="FL561">아이디</div></th>
																<th scope="col"><div data-langcode="FA1399">부서</div></th>
																<th scope="col"><div data-langcode="H333">이메일</div></th>
																<th scope="col"><div data-langcode="H358">휴대폰 번호</div></th>
																<th scope="col"><div data-langcode="FA1449">관리자</div></th>
															</tr>
															</thead>
														</table>
														<!-- scroll -->
														<div id="disableProjectUserDiv" class="scrollbox" style="max-height: 195px; border-bottom:1px solid #c5c6cb;">
															<table cellpadding="0" cellspacing="0">
																<caption></caption>
																<colgroup>
																	<col style="width:17%;">
																	<col style="width:27%;">
																	<col style="width:15%;">
																	<col style="">
																	<col style="width:13%;">
																	<col style="">
																</colgroup>
																<tbody id="mngr_tbody_Ondisable">
																<tr>
																	<td>홍길동</td>
																	<td>desk383</td>
																	<td><span class="ellipsis">jaedong@joins.com</span></td>
																	<td>01089090918</td>
																	<td>-</td>
																</tr>
																</tbody>
															</table>
														</div>
														<!-- //scroll -->
													</div>
													<!-- //리스트테이블 -->
												</td>
											</tr>
										</tbody></table>
									</div>
									<!-- // -->
						
									<div class="t_center mgt15 btn_wrap">
										<div style="display: inline; float: left"><a id="delete_project" style="cursor:pointer; display: none" class="btn btn_popstyle2 bgred" data-langcode="H381">삭제</a></div>
										<div style="display: inline; float: right"><a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="H359">확인</a></div>
						
									</div>
								</div>
							</div>
							<div class="bgmodal" style="display:none;"></div>
						</div>
						
						<!-- 안내문구 -->
						<div id="adminDes" style="padding: 15px 20px;
						    background-color: #f9f9fb; position:unset;
							display:none;" class="infotxt1_style mgt20">
							<ul>
								<li>· <span data-langcode="">이용중지된 프로젝트 삭제시 DB에서 삭제되어 관련 파일/게시글/채팅방 등 복구가 불가능합니다.</span></li>
								<li>· <span data-langcode="">마드라스체크에서는 삭제로 인한 자료 및 히스토리 유실에 대한 책임을 일체 지지 않습니다.</span></li>
								<li>· <span data-langcode="">ex) 프로젝트 자동 이용중지 주기를 7일로 설정하는 경우 2022-11-03 13:00에 최근활동일이 기록된 프로젝트는 2022-11-10 24:00, 즉 2022-11-11 00:00에 이용중지 처리됩니다</span></li>
							</ul>
						</div>
						<!-- //안내문구 -->
						
						
                </span> <!-- 프로젝트 관리 끝 -->
                
                
                
                
                
                
                
                
                
                
                
                
                <span id="회사_프로젝트_관리" class="left_menu" style="display: none;"> <!-- 회사 프로젝트 관리 시작 -->
                    











<!-- 대타이틀 -->
<div class="titleh1_style">
	<div>
		<h1 id="flow-comm-proj-title">회사 프로젝트 관리</h1>
	</div>
</div>
<!-- //대타이틀 -->

<!-- 검색테이블 -->
<div class="srch_table mgt10">
	<table cellpadding="0" cellspacing="0">
		<colgroup>
		<col style="width:350px;">
		<col style="width:110px;">
		<col style="width:310px;">
		<col>
		</colgroup>
		<!--
		<tr>
			<td scope="row">
				<select style="width:330px;">
					<option>회사명</option>
				</select>
			</th>
			<th scope="row">
				<select style="width:100px;">
					<option>생성일</option>
					<option>최근 활동일</option>
				</select>
			</th>
			<td>
				<select style="width:130px;">
					<option>2012-02-22</option>
				</select>&nbsp;-
				<select style="width:130px;">
					<option>2012-02-22</option>
				</select>
			</td>
			<td><a style="cursor:pointer" class="btn srchbtn_style">검색</a></td>
		</tr>
		-->

		<tbody><tr>
			<td colspan="3">
				<select style="width:120px; cursor:pointer">
					<option data-langcode="FL567">프로젝트명</option>
				</select>
				<input id="comm_proj_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:490px;" data-langcode="FL567">
				<a id="srch-companyprj-bt" style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>
			</td>
			<td colspan="2" id="excel-prj-bt-where"></td>
		</tr>

	</tbody></table>
</div>
<!-- //검색테이블 -->

<!-- btn both -->
<div class="btn_both top_line mgb10">
	<div class="left"><a id="addProjBtn" class="btn plusbtn_style">+ <span data-langcode="FA1434">추가</span></a></div>
</div>

<!-- 리스트테이블 -->
<div id="comm_proj_list_table" class="list_table mgt10 mgb15">
	<table cellpadding="0" cellspacing="0">
		<caption></caption>
		<colgroup>
		<col style="">
		<col style="">
		<col style="">
		
		<col style="">
		<col style="">
		<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><div><span data-langcode="FA1605">최근 활동일</span><a data="TOP_RGSR_DTTM" style="cursor:pointer" class=""></a></div></th>
				<th scope="col"><div><span data-langcode="FA1436">개설일</span><a data="RGSN_DTTM" style="cursor:pointer" class=""></a></div></th>
				<th scope="col"><div><span data-langcode="FL567">프로젝트명</span><a data="TTL" style="cursor:pointer" class=""></a></div></th>
				
				<!-- <th scope="col"><div>참여자수<a data="SENDIENCE_CNT" style="cursor:pointer" class="sort"></a></div></th>-->
				<th scope="col"><div><span data-langcode="FA1438">게시물</span><a data="COMMT_CNT" style="cursor:pointer" class=""></a></div></th>
				<th scope="col"><div><span data-langcode="FA1439">댓글</span><a data="REMARK_CNT" style="cursor:pointer" class=""></a></div></th>
				<th scope="col"><div><span data-langcode="FA1440">작성자 아이디</span><a data="RGSR_NMID" style="cursor:pointer" class=""></a></div></th>
			</tr>
		</thead>
	</table>
	<!-- scroll -->
	<div id="proj_scroll" class="scrollbox" style="">
		<table cellpadding="0" cellspacing="0">
			<caption></caption>
			<colgroup>
			<col style="">
			<col style="">
			<!--<col style="">-->
			<col style="">
			
			<col style="">
			<col style="">
			<col style="">
			</colgroup>
			<tbody id="comm_proj_tbody">
				<tr style="cursor: pointer; background-color: rgb(255, 255, 255);"><td>2023-06-23, 10:05</td><td>2023-06-23, 10:05</td><td style="text-align: left; padding-left: 10px;">회사프로젝트</td><td>0</td><td>0</td><td>하늘하하늘(apzkemfht@proton.me)</td></tr>
				<tr style="cursor: pointer; background-color: rgb(255, 255, 255);"><td>2023-06-23, 10:05</td><td>2023-06-23, 10:05</td><td style="text-align: left; padding-left: 10px;">회사프로젝트</td><td>0</td><td>0</td><td>하늘하하늘(apzkemfht@proton.me)</td></tr>
			</tbody>
		</table>
	</div>
	<!-- //scroll -->
</div>
<!-- //리스트테이블 -->

<div id="addProjLayer" class="bgmodal_wrap" style="display:none;">

	<div class="lyaer_popup_wrap" id="회사_프로젝트_정보_추가" style="width:900px;margin-top:-370px;margin-left:-450px; display:none;">
		<div class="lyaer_popup_top">
			<h1><span data-langcode="FA1834">회사 프로젝트 정보</span><input style="cursor:pointer" id="회사_프로젝트_정보_X" type="button" class="pop_close" title="닫기"></h1>
		</div>
		<div class="lyaer_popup_cont">
			<div class="srch_table mgt10">
				<table cellpadding="0" cellspacing="0" class="htlowtype">
					<colgroup>
					<col style="width:150px;"><col>
					</colgroup>
					<tbody><tr>
						<th scope="row" data-langcode="FL567">프로젝트명</th>
						<td><input name="proj_name" type="text" placeholder="프로젝트명을 입력하세요 " style="width:98.5%;" maxlength="100" data-langcode="FA1441"></td>
					</tr>
					<tr>
						<th scope="row" data-langcode="H420">관리자</th>
						<td>
							<span id="mngrAlert" style="color:red"></span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<!-- 리스트테이블 -->
							<div id="mngr_list_table" class="list_table">
								<table cellpadding="0" cellspacing="0">
									<caption></caption>
									<colgroup>
									<col style="width:17%;">
									<col style="width:27%;">
									<!--<col style="width:15%;"> -->
									<col style="width:15%;">
									<col style=";">
									<col style="width:13%;">
									<col style="width:9%;" class="add_exp">
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><div data-langcode="FA1444">관리자 이름</div></th>
											<th scope="col"><div data-langcode="FL561">아이디</div></th>
											<!-- <th scope="col"><div>회사</div></th> -->
											<th scope="col"><div data-langcode="FA1399">부서</div></th>
											<th scope="col"><div data-langcode="H333">이메일</div></th>
											<th scope="col"><div data-langcode="H358">휴대폰 번호</div></th>
											<th scope="col" class="add_exp"><div data-langcode="FA1449">관리자</div></th>
										</tr>
									</thead>
								</table>
								<!-- scroll -->
								<div class="scrollbox" style="max-height: 195px; border-bottom:1px solid #c5c6cb;">
									<table cellpadding="0" cellspacing="0">
										<caption></caption>
										<colgroup>
										<col style="width:17%;">
										<col style="width:27%;">
										<!--<col style="width:15%;"> -->
										<col style="width:15%;">
										<col style="">
										<col style="width:13%;">
										<col style="width:9%;" class="add_exp">
										</colgroup>
										<tbody id="mngr_tbody">
											<tr>
												<td>홍길동</td>
												<td>desk383</td>
												<td>중앙일보</td>
												<td><span class="ellipsis">jaedong@joins.com</span></td>
												<td>01089090918</td>
												<td><a style="cursor:pointer" class="tbold_uline">[해제]</a></td>
											</tr>
										</tbody>
									</table>
								</div>
								<!-- //scroll -->
							</div>
							<!-- //리스트테이블 -->
						</td>
					</tr>
					<tr id="comprj_mngr_wr_yn_area" style="">
						<th scope="row" data-langcode="CM1330">글 작성 권한</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="comprj_mngr_wr_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="comprj_mngr_wr_yn" value="Y" style="cursor: pointer;">&nbsp;<span id="comprj_mngr_wr_text" style="cursor:pointer" data-langcode="CM1332">관리자만 글 작성 가능</span></label>
							</div>
						</td>
					</tr>
					<tr id="comprj_mngr_wr_cm_yn_area">
						<th scope="row" data-langcode="CM1330">댓글 작성</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="comprj_mngr_wr_cm_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="comprj_mngr_wr_cm_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="CM1332">관리자만</span></label>
							</div>
						</td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1333">글 조회</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input type="radio" name="comprj_srch_auth_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="comprj_srch_auth_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1455">관리자 + 글 작성 본인만</span></label>
								<span id="mngrAlert" style="color:red" data-langcode="FA1456">※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span>
							</div>
					    </td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1338">파일 다운로드</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input type="radio" name="comprj_prj_auth" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="comprj_prj_auth" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">관리자 + 글 작성 본인만</span></label>
								<span style="color: #ff0000">※ 다운로드 및 열람 모두 제한됩니다(첨부 파일, 이미지)</span>
							</div>
					    </td>
					</tr>
					<tr id="writeEditAuthTypeComm" style="">
						<th scope="row">글 수정</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="writeEditAuth" value="ALL" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="writeEditAuth" value="MNGRMYSELF" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">관리자 + 글 작성 본인만</span></label>
								<label class="on"><input type="radio" name="writeEditAuth" value="MYSELF" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">글 작성 본인만</span></label>
							</div>
						</td>
					</tr>
					<tr id="postModDelAuthTypeComm" style="display: none">
						<th scope="row" data-langcode="">게시물 수정/삭제 방지</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="postModDelAuth" value="Y" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="postModDelAuth" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>
					<tr id="replyModDelAuthTypeComm" style="display: none">
						<th scope="row" class="padding-bottom-20" data-langcode="">댓글 수정/삭제 방지</th>
						<td class="padding-bottom-20">
							<div class="radiobox">
								<label class="on"><input type="radio" name="replyModDelAuth" value="Y" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="replyModDelAuth" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>

					<tr id="anoymousComm" style="display:none">
						<th scope="row" data-langcode="" class="padding-bottom-20">익명방 여부</th>
						<td class="padding-bottom-20">
							<div class="">
								<label><input name="anoymous" type="checkbox"><span>  <span style="color: red">※익명방 여부 설정이후 변경 불가</span></span></label>
							</div>
						</td>
					</tr>
					<tr id="guestPrjInit" style="display:none">
						<th scope="row" data-langcode="NOTRANSLATE">외부인 포함</th>
						<td>
							<div id="guestInvtLayer" class="radiobox">
								<label class="on"><input type="radio" name="cmnm_prj_init_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">???include???</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="cmnm_prj_init_yn" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">???exclude???</span></label>
								<span style="color: red">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>
					<tr id="projectType" class="border-top" style="display: none">
						<th scope="row" data-langcode="CM1338">일반 프로젝트 변경</th>
						<td>
							<div class="radiobox">
								<label class="on"><input id="projectTypeCheckBox" type="checkbox" name="" value="N">&nbsp;<span style="cursor:pointer" data-langcode="H197"></span></label>&nbsp;&nbsp;
								<span style="color: #ff0000">※ 회사 프로젝트를 더 이상 운영하지 않을 때 사용합니다 (회사 프로젝트 복원 불가)</span>
							</div>
						</td>
					</tr>
				</tbody></table>
			</div>
			<!-- // -->
			<div class="t_center mgt15 btn_wrap">
				<div class="left"><a id="del_proj" style="cursor: pointer; display: none;" class="btn btn_popstyle2 bgred" data-langcode="H381">삭제</a></div>
				<a id="save-or-edit" style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="CT927">저장</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a style="cursor:pointer" id="회사_프로젝트_정보_취소" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	<div class="lyaer_popup_wrap" id="회사_프로젝트_정보_수정" style="width:900px;margin-top:-370px;margin-left:-450px;display:none;">
		<div class="lyaer_popup_top">
			<h1><span data-langcode="FA1834">회사 프로젝트 정보</span><input style="cursor:pointer" type="button" class="pop_close" title="닫기"></h1>
		</div>
		<div class="lyaer_popup_cont">
			<div class="srch_table mgt10">
				<table cellpadding="0" cellspacing="0" class="htlowtype">
					<colgroup>
					<col style="width:150px;"><col>
					</colgroup>
					<tbody><tr>
						<th scope="row" data-langcode="FL567">프로젝트명</th>
						<td><input name="proj_name" type="text" placeholder="프로젝트명을 입력하세요 " style="width:98.5%;" maxlength="100" data-langcode="FA1441"></td>
					</tr>
					<tr>
						<th scope="row" data-langcode="H420">프로젝트 멤버</th>
						<td>
							<span id="mngrAlert_2" style="color:red"></span>
							<span class="grAlert" style="color:red; display:none;">프로젝트명은 3글자 이상 입력해주세요</span>
						</td>
					</tr>
					<tr>
						<td colspan="2">
							<!-- 리스트테이블 -->
							<div id="mngr_list_table_2" class="list_table">
								<table cellpadding="0" cellspacing="0">
									<caption></caption>
									<colgroup>
									<col style="width:17%;">
									<col style="width:27%;">
									<!--<col style="width:15%;"> -->
									<col style="width:15%;">
									<col style=";">
									<col style="width:13%;">
									<col style="width: 9%; display: table-column;" class="add_exp">
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><div data-langcode="FA1444">관리자 이름</div></th>
											<th scope="col"><div data-langcode="FL561">직책</div></th>
											<!-- <th scope="col"><div>회사</div></th> -->
											<th scope="col"><div data-langcode="FA1399">부서</div></th>
											<th scope="col"><div data-langcode="H333">이메일</div></th>
											<th scope="col"><div data-langcode="H358">휴대폰 번호</div></th>
											<th scope="col" class="add_exp" style="display: table-cell;"><div data-langcode="FA1449">관리자</div></th>
										</tr>
									</thead>
								</table>
								<!-- scroll -->
								<div class="scrollbox" style="max-height: 195px; border-bottom:1px solid #c5c6cb;">
									<table cellpadding="0" cellspacing="0">
										<caption></caption>
										<colgroup>
										<col style="width:17%;">
										<col style="width:27%;">
										<!--<col style="width:15%;"> -->
										<col style="width:15%;">
										<col style="">
										<col style="width:13%;">
										<col style="width: 9%; display: table-column;" class="add_exp">
										</colgroup>
										<tbody id="mngr_tbody_2"><tr><td>하늘하하늘</td><td><span class="user_ids">apzkemfht@proton.me</span></td><td></td><td>apzkemfht@proton.me</td><td></td><td>&nbsp;<a class="out_bt tbold_uline">[해제]</a></td></tr></tbody>
									</table>
								</div>
								<!-- //scroll -->
							</div>
							<!-- //리스트테이블 -->
						</td>
					</tr>
					<tr id="comprj_mngr_wr_yn_area_2" style="">
						<th scope="row" data-langcode="CM1330">글 작성 권한</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="mprj_mngr_wr_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="mprj_mngr_wr_yn" value="Y" style="cursor: pointer;">&nbsp;<span id="comprj_mngr_wr_text_2" style="cursor:pointer" data-langcode="CM1332">관리자만 글 작성 가능</span></label>
							</div>
						</td>
					</tr>
					<tr id="comprj_mngr_wr_cm_yn_area_2">
						<th scope="row" data-langcode="CM1330">댓글 작성</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="mprj_mngr_wr_cm_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="mprj_mngr_wr_cm_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="CM1332">관리자만</span></label>
							</div>
						</td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1333">글 조회</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input type="radio" name="mprj_srch_auth_yn" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="mprj_srch_auth_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1455">관리자 + 글 작성 본인만</span></label>
								<span id="mngrAlert_2" style="color:red" data-langcode="FA1456">※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span>
							</div>
					    </td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1338">파일 다운로드</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input type="radio" name="mprj_prj_auth" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="mprj_prj_auth" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">관리자 + 글 작성 본인만</span></label>
								<span style="color: #ff0000">※ 다운로드 및 열람 모두 제한됩니다(첨부 파일, 이미지)</span>
							</div>
					    </td>
					</tr>
					<tr id="writeEditAuthTypeComm_2" style="">
						<th scope="row">글 수정</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="iteEditAuth" value="MNGRMYSELF" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">관리자 + 글 작성 본인만</span></label>
								<label class="on"><input type="radio" name="iteEditAuth" value="MYSELF" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">글 작성 본인만</span></label>
							</div>
						</td>
					</tr>
					<tr id="postModDelAuthTypeComm_2" style="display: none">
						<th scope="row" data-langcode="">게시물 수정/삭제 방지</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="ostModDelAuth" value="Y" checked="" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="ostModDelAuth" value="N" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>
					<tr id="replyModDelAuthTypeComm_2" style="display: none">
						<th scope="row" class="padding-bottom-20" data-langcode="">댓글 수정/삭제 방지</th>
						<td class="padding-bottom-20">
							<div class="radiobox">
								<label class="on"><input type="radio" name="replyModDelAuth" value="Y" checked="" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="replyModDelAuth" value="N" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>

					<tr id="anoymousComm_2" style="display:none">
						<th scope="row" data-langcode="" class="padding-bottom-20">익명방 여부</th>
						<td class="padding-bottom-20">
							<div class="">
								<label><input name="anoymous" type="checkbox"><span>  <span style="color: red">※익명방 여부 설정이후 변경 불가</span></span></label>
							</div>
						</td>
					</tr>
					<tr id="guestPrjInit_2" style="display:none">
						<th scope="row" data-langcode="NOTRANSLATE">외부인 포함</th>
						<td>
							<div id="guestInvtLayer_2" class="radiobox" style="display: none;">
								<label class="on"><input type="radio" name="cmnm_prj_init_yn" value="Y" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">???include???</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="cmnm_prj_init_yn" value="N" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">???exclude???</span></label>
								<span style="color: red">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>
					<tr id="commProjectEnd_2" class="border-top" style="display: none;">
						<th scope="row" data-langcode="">프로젝트 상태</th>
						<td>
							<div class="before-terminate-case">
								<button class="button-project-terminate">종료하기</button>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span>
							</div>
							<div class="after-terminate-case">
								<span style="font-weight: bold;">종료된 프로젝트</span>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span>
							</div>
						</td>
					</tr>
				</tbody></table>
			</div>
			<!-- // -->

			<div class="t_center mgt15 btn_wrap">
				<div class="left"><a id="del_proj_2" style="cursor: pointer; display: inline-block;" class="btn btn_popstyle2 bgred" data-langcode="H381">삭제</a></div>
				<a id="save-or-edit_2" style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="CT927">수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	

	<!-- 관리자페이지 -->
	<div id="proj_mngr_layer" class="layer_popup_wrap" style="display:none; z-index:1001; width: 570px; min-height: 180px;
	       padding-bottom: 20px; margin-top: -300px; margin-left: -285px;">
		<div class="layer_popup_top">
		<h1 data-langcode="AA0107">관리자 선택</h1>
			<a style="cursor:pointer" class="pop_close"><img src="https://flow.team/js/admin/assets/img/btn_popclose.gif" alt="닫기"></a>

			<div class="srch_table mgt20">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col style="width:15%">
						<col style="width:35%">
						<col style="width:60%">
					</colgroup>
					<tbody>
					<tr>
						<td>
							<select id="comm_user_catg">
								<option data-langcode="H331">이름</option>
								<option data-langcode="FL561">아이디</option>
							</select>
						</td>
						<td><input id="comm_user_srch_word" type="text" style=""></td>
						<td><a style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="layer_popup_cont">
			<div class="list_table mgt20 mgb15">
				<table cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
					<col style="">
					<col style="">
					<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><div><span data-langcode="H331">이름</span><a data="TTL" style="cursor:pointer" class=""></a></div></th>
							<th scope="col"><div><span data-langcode="FL561">아이디</span><a data="SENDIENCE_CNT" style="cursor:pointer" class=""></a></div></th>
							<th scope="col"><div><span data-langcode="CLP1003">선택</span><a data="COMMT_CNT" style="cursor:pointer" class=""></a></div></th>
						</tr>
					</thead>
				</table>
				<!-- scroll -->
				<div id="mngr_scroll" class="scrollbox" style="height:200px">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
						<col style="">
						<col style="">
						<col style="width:20%">
						</colgroup>
						<tbody id="comm_user_tbody">
							<tr>
								<td>웹 최신 디자인 트랜드 공유</td>
								<td>130</td>
								<td><a href="#" class="tbold_uline">[선택]</a></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //scroll -->
			</div>
			<!-- //리스트테이블 -->
		</div>

		<div class="t_center mgt15 btn_wrap">
			<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
		</div>

	</div>
	<div class="bgmodal" style="display:none;"></div>






	<!-- 기업추가 페이지 -->
	<div id="commListLayer" class="bgmodal_wrap" style="display:none;">

		<div class="lyaer_popup_wrap" style="width:350px;height:330px;margin-top:-200px;margin-left:-375px;">
			<input type="button" class="pop_close" title="닫기">
			<div class="lyaer_popup_top">
				<h1 data-langcode="FA1470">접속 장치 정보</h1>
			</div>
			<div class="lyaer_popup_cont">
				<!-- 리스트테이블 -->
				<div class="list_table mgt15">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
							<col style="width:15%;">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><div data-langcode="CLP1003">선택</div></th>
								<th scope="col"><div data-langcode="H330">회사명</div></th>
							</tr>
						</thead>
					</table>
					<!-- scroll -->
					<div class="scrollbox mCustomScrollbar _mCS_2 mCS_no_scrollbar" style="max-height: 185px;"><div id="mCSB_2" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_2_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
						<table cellpadding="0" cellspacing="0">
							<caption></caption>
							<colgroup>
								<col style="width:15%;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td>111</td>
									<td>웹케시</td>
								</tr>
							</tbody>
						</table>
					</div><div id="mCSB_2_scrollbar_vertical" class="mCSB_scrollTools mCSB_2_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_2_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
					<!-- //scroll -->
				</div>
				<!-- //리스트테이블 -->

				<div class="t_center mgt15 btn_wrap">
					<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="cursor:pointer" class="btn btn_popstyle1" data-langcode="CD755">취소</a>
				</div>
			</div>
		</div>
	</div>

</div>



	<!-- 관리자페이지 -->
	<div id="proj_mngr_layer" class="layer_popup_wrap" style="display:none; z-index:1001; width: 570px; min-height: 180px;
	       padding-bottom: 20px; margin-top: -300px; margin-left: -285px;">
		<div class="layer_popup_top">
		<h1 data-langcode="AA0107">관리자 선택</h1>
			<a style="cursor:pointer" class="pop_close"><img src="https://flow.team/js/admin/assets/img/btn_popclose.gif" alt="닫기"></a>

			<div class="srch_table mgt20">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col style="width:15%">
						<col style="width:35%">
						<col style="width:60%">
					</colgroup>
					<tbody>
					<tr>
						<td>
							<select id="comm_user_catg">
								<option data-langcode="H331">이름</option>
								<option data-langcode="FL561">아이디</option>
							</select>
						</td>
						<td><input id="comm_user_srch_word" type="text" style=""></td>
						<td><a style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="layer_popup_cont">
			<div class="list_table mgt20 mgb15">
				<table cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
					<col style="">
					<col style="">
					<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><div><span data-langcode="H331">이름</span><a data="TTL" style="cursor:pointer" class=""></a></div></th>
							<th scope="col"><div><span data-langcode="FL561">아이디</span><a data="SENDIENCE_CNT" style="cursor:pointer" class=""></a></div></th>
							<th scope="col"><div><span data-langcode="CLP1003">선택</span><a data="COMMT_CNT" style="cursor:pointer" class=""></a></div></th>
						</tr>
					</thead>
				</table>
				<!-- scroll -->
				<div id="mngr_scroll" class="scrollbox" style="height:200px">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
						<col style="">
						<col style="">
						<col style="width:20%">
						</colgroup>
						<tbody id="comm_user_tbody">
							<tr>
								<td>웹 최신 디자인 트랜드 공유</td>
								<td>130</td>
								<td><a href="#" class="tbold_uline">[선택]</a></td>
							</tr>
						</tbody>
					</table>
				</div>
				<!-- //scroll -->
			</div>
			<!-- //리스트테이블 -->
		</div>

		<div class="t_center mgt15 btn_wrap">
			<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
		</div>

	</div>
	<div class="bgmodal" style="display:none;"></div>






	<!-- 기업추가 페이지 -->
	<div id="commListLayer" class="bgmodal_wrap" style="display:none;">

		<div class="lyaer_popup_wrap" style="width:350px;height:330px;margin-top:-200px;margin-left:-375px;">
			<input type="button" class="pop_close" title="닫기">
			<div class="lyaer_popup_top">
				<h1 data-langcode="FA1470">접속 장치 정보</h1>
			</div>
			<div class="lyaer_popup_cont">
				<!-- 리스트테이블 -->
				<div class="list_table mgt15">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
							<col style="width:15%;">
							<col>
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><div data-langcode="CLP1003">선택</div></th>
								<th scope="col"><div data-langcode="H330">회사명</div></th>
							</tr>
						</thead>
					</table>
					<!-- scroll -->
					<div class="scrollbox mCustomScrollbar _mCS_2 mCS_no_scrollbar" style="max-height: 185px;"><div id="mCSB_2" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: none;" tabindex="0"><div id="mCSB_2_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
						<table cellpadding="0" cellspacing="0">
							<caption></caption>
							<colgroup>
								<col style="width:15%;">
								<col>
							</colgroup>
							<tbody>
								<tr>
									<td>111</td>
									<td>웹케시</td>
								</tr>
							</tbody>
						</table>
					</div><div id="mCSB_2_scrollbar_vertical" class="mCSB_scrollTools mCSB_2_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_2_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
					<!-- //scroll -->
				</div>
				<!-- //리스트테이블 -->

				<div class="t_center mgt15 btn_wrap">
					<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
					<a style="cursor:pointer" class="btn btn_popstyle1" data-langcode="CD755">취소</a>
				</div>
			</div>
		</div>
	</div>





                </span> <!-- 회사 프로젝트 관리 끝 -->
                
                
                
                
                
                
                
                
                
                <span id="공개_프로젝트_관리" class="left_menu" style="display: none;"> <!-- 공개 프로젝트 관리 시작 -->
                    











<!-- 대타이틀 -->
<div class="titleh1_style">
	<div>
		<h1 id="flow-open-proj-title">공개 프로젝트 관리</h1>
	</div>
</div>
<!-- //대타이틀 -->

<!-- 검색테이블 -->
<div class="srch_table mgt10">
	<table cellpadding="0" cellspacing="0">
		<colgroup>
			<col style="width: 350px;">
			<col style="width: 110px;">
			<col style="width: 310px;">
			<col>
		</colgroup>
		<tbody><tr>
			<!--
			<td scope="row">
				<select style="width:330px;">
					<option>회사명</option>
				</select>
			</th>
			<th scope="row">
				<select style="width:100px;">
					<option>생성일</option>
					<option>최근 활동일</option>
				</select>
			</th>
			<td>
				<select style="width:130px;">
					<option>2012-02-22</option>
				</select>&nbsp;-
				<select style="width:130px;">
					<option>2012-02-22</option>
				</select>
			</td>
			<td><a style="cursor:pointer" class="btn srchbtn_style">검색</a></td>
		</tr>
		 -->
		</tr><tr>
			<td colspan="4">
			<select style="width: 120px; cursor: pointer">
					<option data-langcode="FL567">프로젝트명</option>
			</select>
			<input id="open_proj_srch_word" data-langcode="FL567" type="text" placeholder="검색어를 입력해주세요" style="width: 490px;">
			<a id="srch-openprj-bt" style="cursor: pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>
			</td>
			<td id="excel-open-prj-bt-where"></td>
		</tr>
	</tbody></table>
</div>
<!-- //검색테이블 -->

<!-- btn both
<div class="btn_both top_line mgb10">
	<div class="left"><a style="cursor:pointer" class="btn plusbtn_style">+ 등록</a></div>
</div>
-->

<!-- 리스트테이블 -->
<div class="list_table mgt10 mgb15">
	<table cellpadding="0" cellspacing="0">
		<caption></caption>
		<colgroup>
			<col style="">
			<col style="">
			
			<col style="">
			<col style="">
			<col style="">
			<col style="">
			<col style="">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><div>
						<span data-langcode="FA1593">카테고리명</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col">
					<div>
						<span data-langcode="FL567">프로젝트명</span><a style="cursor: pointer" class=""></a>
					</div>
				</th>
				
				<th scope="col"><div>
						<span data-langcode="FA1602">참여자</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1438">게시물</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1439">댓글</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1605">최근 활동일</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1606">개설일</span><a style="cursor: pointer" class=""></a>
					</div></th>
			</tr>
		</thead>
	</table>
	<!-- scroll -->
	<div id="open_scroll" class="scrollbox">
		<table id="open_table" cellpadding="0" cellspacing="0">
			<caption></caption>
			<thead style="display:none;">
			<tr>
				<th scope="col"><div>
						<span data-langcode="FA1593">카테고리명</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FL567">프로젝트명</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1602">참여자</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1438">게시물</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1439">댓글</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1605">최근 활동일</span><a style="cursor: pointer" class=""></a>
					</div></th>
				<th scope="col"><div>
						<span data-langcode="FA1606">개설일</span><a style="cursor: pointer" class=""></a>
					</div></th>
			</tr>
		</thead>
			<colgroup>
				<col style="">
				<col style="">
				
				<col style="">
				<col style="">
				<col style="">
				<col style="">
				<col style="">
			</colgroup>
			<tbody id="open_proj_tbody"><tr><td>동호회</td><td style="text-align: left; padding-left: 10px;">Yo!</td><td>3</td><td>11</td><td>0</td><td>2023-06-16, 19:26</td><td>2023-06-14, 16:29</td></tr></tbody>
		</table>
	</div>
	<!-- //scroll -->
</div>
<!-- //리스트테이블 -->



<div id="projEditPopUp" class="bgmodal_wrap" style="display:none;">

	<div class="lyaer_popup_wrap" style="width:900px;margin-top:-370px;margin-left:-450px;">
		<div class="lyaer_popup_top">
			<h1><span data-langcode="FA1834">공개 프로젝트 정보</span><input style="cursor:pointer" type="button" class="pop_close" title="닫기"></h1>
		</div>
		<div class="lyaer_popup_cont">
			<div class="srch_table mgt10">
				<table cellpadding="0" cellspacing="0" class="htlowtype">
					<colgroup>
					<col style="width:150px;"><col>
					</colgroup>


					<!--
					<tr class="vtop">
						<th scope="row">참여 회사</th>
						<td>
							<div class="complist_wrap">
								<div class="complist"><a style="cursor:pointer"class="btn btn_style1_s">설정</a>&nbsp;<span>조인스중앙</span><span>JTBC</span><span>휘닉스파크</span><span>만약두줄로넘어갈때</span><span>이렇게</span><span>이렇게</span><span>이렇게</span><span>이렇게</span><span>이렇게</span><span>이렇게</span><span>조인스중앙</span><span>JTBC</span><span>휘닉스파크조인스중앙</span><span>JTBC</span><span class="last">휘닉스파</span></div>
							</div>
							<p><label style="font-size:13px;color:#afafaf;"><input type="checkbox"> 협력사 직원을 제외하는 경우, 여기에 체크하세요</label></p>
						</td>
					</tr>
					 -->

					<tbody><tr>
						<th scope="row" data-langcode="H420">카테고리</th>
						<td>
							<select id="openProjectCategory">
							</select>
						</td>
					</tr>

					<tr>
						<th scope="row" data-langcode="FL567">프로젝트명</th>
						<td><input name="open_proj_name" type="text" placeholder="프로젝트명을 입력하세요 " style="width:98.5%;" maxlength="100" data-langcode="FA1441"></td>
					</tr>

					<!-- 관리자 추가 버튼 -->
					<tr>
						<th scope="row" data-langcode="H420">프로젝트 멤버</th>
						<td>
							<span class="grAlert" style="color:red; display:none;">프로젝트명은 3글자 이상 입력해주세요</span>
						</td>
					</tr>

					<tr>
						<td colspan="2">
							<!-- 리스트테이블 -->
							<div id="mngr_list_table" class="list_table">
								<table cellpadding="0" cellspacing="0">
									<caption></caption>
									<colgroup>
									<col style="width:17%;">
									<col style="width:27%;">
									<!--<col style="width:15%;"> -->
									<col style="width:15%;">
									<col style=";">
									<col style="width:13%;">
									<col style="width:9%;" class="add_exp">
									</colgroup>
									<thead>
										<tr>
											<th scope="col"><div data-langcode="FA1444">관리자 이름</div></th>
											<th scope="col"><div data-langcode="FL561">직책</div></th>
											<!-- <th scope="col"><div>회사</div></th> -->
											<th scope="col"><div data-langcode="FA1399">부서</div></th>
											<th scope="col"><div data-langcode="H333">이메일</div></th>
											<th scope="col"><div data-langcode="H358">휴대폰 번호</div></th>
											<th scope="col" class="add_exp"><div data-langcode="FA1449">관리자</div></th>
										</tr>
									</thead>
								</table>
								<!-- scroll -->
								<div class="scrollbox" style="max-height: 195px; border-bottom:1px solid #c5c6cb;">
									<table cellpadding="0" cellspacing="0">
										<caption></caption>
										<colgroup>
										<col style="width:17%;">
										<col style="width:27%;">
										<!--<col style="width:15%;"> -->
										<col style="width:15%;">
										<col style="">
										<col style="width:13%;">
										<col style="width:9%;" class="add_exp">
										</colgroup>
										<tbody id="mngr_tbody3"></tbody>
									</table>
								</div>
								<!-- //scroll -->
							</div>
							<!-- //리스트테이블 -->
						</td>
					</tr>
					<!--
					<tr class="edit_text">
						<th  scope="row">활동요약</th>
						<td>참여자수 : 30 / 게시물 : 100 / 댓글 : 40 / 파일용량(MB) : 300 / 최근활동일 : 2018.05.04</td>
					</tr>
					<tr class="edit_text">
						<th  scope="row">생성정보</th>
						<td>2018.01.03 / 이학준 (desk383)</td>
					</tr>
					 -->
					<tr id="openprj_mngr_wr_yn_area">
					    <th scope="row" data-langcode="CM1330">글 작성 권한</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input checked="" type="radio" name="openmngr_wr_yn" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="openmngr_wr_yn" value="Y" style="cursor: pointer;">&nbsp;<span id="openmngr_wr_text" style="cursor:pointer" data-langcode="CM1332">관리자만 글 작성 가능</span></label>
							</div>
					    </td>
					</tr>
					
					<tr id="openprj_mngr_wr_cm_yn_area">
						<th scope="row" data-langcode="CM1330">댓글 작성</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="openmngr_wr_cm_yn" value="N" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="openmngr_wr_cm_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="CM1332">관리자만</span></label>
							</div>
						</td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1333">글 조회</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input checked="" type="radio" name="srch_auth_yn" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="srch_auth_yn" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1455">관리자 + 글 작성 본인만</span></label>
								<span id="mngrAlert" style="color:red" data-langcode="FA1456">※ 등록된 게시물의 조회 권한은 변경되지 않음(직접 변경 필요)</span>
							</div>
					    </td>
					</tr>
					<tr>
					    <th scope="row" data-langcode="CM1338">파일 다운로드</th>
						<td>
					        <div class="radiobox">
								<label class="on"><input checked="" type="radio" name="prj_auth" value="N" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="prj_auth" value="Y" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="FA1459">관리자 + 글 작성 본인만</span></label>
								<span style="color: red">※ 다운로드 및 열람 모두 제한됩니다(첨부 파일, 이미지)</span>
							</div>
					    </td>
					</tr>
					<tr id="writeEditAuthTypeOpen" style="">
						<th scope="row" data-langcode="">글 수정</th>
						<td>
							<div class="radiobox">
<!-- 								<label class="on"><input type="radio" name="writeEditAuth" value="ALL" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">전체</span></label>&nbsp;&nbsp; -->
								<label class="on"><input type="radio" name="writeEditAuth" value="MNGRMYSELF" checked="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">관리자 + 글 작성 본인만</span></label>
								<label class="on"><input type="radio" name="writeEditAuth" value="MYSELF" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">글 작성 본인만</span></label>
							</div>
						</td>
					</tr>

					<tr id="postModDelAuthTypeOpen" style="display: none">
						<th scope="row" data-langcode="">게시물 수정/삭제 방지</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="postModDelAuth" value="Y" checked="" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="postModDelAuth" value="N" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>
					<tr id="replyModDelAuthTypeOpen" style="display: none">
						<th scope="row" data-langcode="">댓글 수정/삭제 방지</th>
						<td>
							<div class="radiobox">
								<label class="on"><input type="radio" name="replyModDelAuth" value="Y" checked="" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="H197">미설정</span></label>&nbsp;&nbsp;
								<label class="on"><input type="radio" name="replyModDelAuth" value="N" disabled="" style="cursor: pointer;">&nbsp;<span style="cursor:pointer" data-langcode="">설정</span></label>
								<span style="color:red" data-langcode="FA1456">※ 프로젝트 생성 후 변경 불가</span>
							</div>
						</td>
					</tr>

					<tr id="anoymousOpen" style="display:none">
						<th scope="row" data-langcode="">익명방 여부</th>
						<td>
							<div class="">
								<label><input name="anoymous" type="checkbox"><span>  <span style="color: red">※익명방 여부 설정이후 변경 불가</span></span></label>
							</div>
						</td>
					</tr>
<!-- 					<tr id="openProjectEnd" class="border-top"> -->
<!-- 						<th scope="row" data-langcode="">프로젝트 상태</th> -->
<!-- 						<td> -->
<!-- 							<div class="before-terminate-case"> -->
<!-- 								<button class="button-project-terminate">종료하기</button>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span> -->
<!-- 							</div> -->
<!-- 							<div class="after-terminate-case"> -->
<!-- 								<span style="font-weight: bold;">종료된 프로젝트</span>&nbsp;&nbsp;<span style="color: red">※ 프로젝트 종료 시, 재 진행이 불가 합니다.</span> -->
<!-- 							</div> -->
<!-- 						</td> -->
<!-- 					</tr> -->
				</tbody></table>
			</div>
			<!-- // -->

			<div class="t_center mgt15 btn_wrap">
				<div class="left"><a id="del_open_proj" style="cursor:pointer" class="btn btn_popstyle2 bgred" data-langcode="H381">삭제</a></div>
				<a id="projEditSubmit" style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="CT927">수정</a>&nbsp;&nbsp;&nbsp;&nbsp;
				<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
			</div>
		</div>
	</div>

	<!-- 관리자 선택 -->
	<div id="proj_mngr_layer" class="layer_popup_wrap" style="display:none; z-index:1001; width: 570px; min-height: 180px;
	       padding-bottom: 20px; margin-top: -300px; margin-left: -285px;">
		<div class="layer_popup_top">
			<h1 data-langcode="AA0107">관리자 선택</h1>
			<a style="cursor:pointer" class="pop_close"><img src="https://flow.team/js/admin/assets/img/btn_popclose.gif" alt="닫기"></a>

			<div class="srch_table mgt20">
				<table cellpadding="0" cellspacing="0">
					<colgroup>
						<col style="width:15%">
						<col style="width:35%">
						<col style="width:60%">
					</colgroup>
					<tbody>
					<tr>
						<td>
							<select id="open_user_catg">
								<option data-langcode="H331">이름</option>
								<option data-langcode="FL561">아이디</option>
							</select>
						</td>
						<td><input id="open_user_srch_word" type="text" style=""></td>
						<td><a style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
					</tr>
					</tbody>
				</table>
			</div>
		</div>

		<div class="layer_popup_cont">
			<div class="list_table mgt20 mgb15">
				<table cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
						<col style="">
						<col style="">
						<col style="width:20%">
					</colgroup>
					<thead>
					<tr>
						<th scope="col">
							<div><span data-langcode="H331">이름</span><a data="TTL" style="cursor:pointer" class=""></a>
							</div>
						</th>
						<th scope="col">
							<div><span data-langcode="FL561">아이디</span><a data="SENDIENCE_CNT" style="cursor:pointer" class=""></a></div>
						</th>
						<th scope="col">
							<div><span data-langcode="CLP1003">선택</span><a data="COMMT_CNT" style="cursor:pointer" class=""></a></div>
						</th>
					</tr>
					</thead>
				</table>
				<!-- scroll -->
				<div id="mngr_scroll" class="scrollbox" style="height:200px">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
							<col style="">
							<col style="">
							<col style="width:20%">
						</colgroup>
						<tbody id="open_user_tbody"></tbody>
					</table>
				</div>
				<!-- //scroll -->
			</div>
			<!-- //리스트테이블 -->
		</div>

		<div class="t_center mgt15 btn_wrap">
			<a style="cursor:pointer" class="btn btn_popstyle1 bgblue" data-langcode="H359">확인</a>&nbsp;&nbsp;&nbsp;&nbsp;
			<a style="cursor:pointer" class="btn btn_popstyle1 pop_close" data-langcode="CD755">취소</a>
		</div>
	</div>
	<div class="bgmodal" style="display:none;"></div>
</div>







                </span> <!-- 공개 프로젝트 관리 끝 -->
                
                
                
                
                
                
                
                
                
                
                
                <span id="공개_프로젝트_카테고리" class="left_menu" style="display: none;"> <!-- 공개 프로젝트 카테고리 시작 -->
                    











<!-- 대타이틀 -->
<div class="titleh1_style">
	<div>
		<h1 id="flow-open-proj-ctgr-title">공개 프로젝트 카테고리</h1>
	</div>
</div>
<!-- //대타이틀 -->

<!-- btn both -->
<div class="btn_both">
	<div class="left">
		<a id="open_catg_edit_bt" style="cursor:pointer" class="btn btn_style1 bgblue" data-langcode="CC681">편집</a>
		<a id="open_catg_save_bt" style="cursor:pointer; display:none" class="btn btn_style1 bgblue" data-langcode="CT927">저장</a>
		<a id="open_catg_cancel_bt" style="cursor:pointer; display:none" class="btn btn_style1" data-langcode="CD755">취소</a>
	</div>
<!-- 	<div class="right"> -->
<!-- 		<span style="vertical-align:middle;" data-langcode="FA1589">상태</span>&nbsp;&nbsp; -->
<!-- 		<label><input id="catg_active" type="checkbox" checked="">&nbsp;<span data-langcode="FA1590">활성</span></label>&nbsp;&nbsp; -->
<!-- 		<label><input id="catg_inactive" type="checkbox">&nbsp;<span data-langcode="FA1591">비활성</span></label> -->
<!-- 	</div> -->
</div>

<!-- 리스트테이블 -->
<div class="list_table type2 mgb15">
	<table cellpadding="0" cellspacing="0">
		<caption></caption>
		<colgroup>
		<col style="width:5%;">
		<col style="width:30%;">
		<col style="width:12%;">
		<col style="width:12%;">
		<col style="width:12%;">
		</colgroup>
		<thead>
			<tr>
				<th scope="col"><div><a id="open_catg_add_bt" style="cursor:pointer; display:none" class="btn_style1">+ <span data-langcode="FA1443">추가</span></a></div></th>
				<th scope="col"><div data-langcode="FA1593">카테고리명</div></th>
				<th scope="col"><div data-langcode="FA1594">프로젝트</div></th>
				<th scope="col"><div data-langcode="FA1589">상태</div></th>
				<th scope="col"><div></div></th>
			</tr>
		</thead>
		<tbody id="open_catg_tbody">
		</tbody>
	</table>
</div>
<!-- //리스트테이블 -->

                </span>  <!-- 공개 프로젝트 카테고리 끝 -->
                
                
                
                
                
                
                
                
                
                
                <span id="구성원_일괄_등록" class="left_menu" style="display:none;">
						<div class="titleh1_style title-return-button">
						    <button id="returnOrgMainBtn" class="return_back"></button>
						    <h1 id="orgRegisterTitle" data-langcode="ORG008">부서 일괄 등록</h1>
						</div>
						<div id="INVITE_EXCEL_UI">
						    <div class="infotxt1_style mgt20">
						        <ul>
						            <li>· <span data-langcode="ORG023">1회 최대 200개의 조직을 등록할 수 있습니다.</span></li>
						            <li>· <span data-langcode="ORG24">"등록 불가능한 행 모아보기" 체크박스 체크 시, 관련 행만 모아볼 수 있습니다</span></li>
						            <li>· <span data-langcode="ORG025">등록 완료 후, 조회 페이지에서 확인 및 편집 가능합니다.</span>
						            </li>
						        </ul>
						        
						            <a href="사용자매뉴얼.html" target="_blank" rel="noopener noreferrer" class="help-view-btn" data-langcode="ADMININVITE007">도움말</a>
						        
						    </div>
						    <!-- 엑셀 밀어넣기 API -->
						    <div class="payment_cont topline_none">
						        <dl>
						            <dd style="padding-bottom:15px">
						                <div id="EMPL_EXCEL_UPLOAD">
						                    <input id="pwd" type="text" value="flow123~!" style="display: none;">
						                    <div>
						                        <input id="fileInputText" type="text" placeholder="xlsx 파일만 업로드 가능합니다." readonly="" style="cursor:pointer;border: 1px solid #e6e6e6;" data-langcode="ADMININVITE008">
						                        <input type="file" style="display:none;" id="excelFileInput" accept="application/vnd.ms-excel,vnd.ms-excel.sheet.macroEnabled.12,application/vnd.openxmlformats-officedocument.spreadsheetml.sheet">
						                        <button id="addDvsnFile" class="upload btn btn_style1 bgblue" data-langcode="ADMININVITE009">파일 등록</button>
						                        <script>
													  var fileInput = document.getElementById("excelFileInput");
													  var fileInputText = document.getElementById("fileInputText");
													
													  fileInput.addEventListener("change", function() {
													    if (fileInput.files.length > 0) {
													      fileInputText.value = fileInput.files[0].name;
													    } else {
													      fileInputText.value = "";
													    }
													  });
													  document.getElementById("addDvsnFile").addEventListener("click", function() {
													    fileInput.click();
													  });
												</script>
						                        <a class="btn btn_style1 invite-excel-download" id="dvsnTemplateDown" data-langcode="ADMININVITE010" href="Images/with_logo.png" download>엑셀 양식 다운로드</a>
						                    </div>
						                    <p class="info mgt5" data-langcode="ADMININVITE021">※ 파일등록 시, 해당 엑셀 표로 아래 표가 초기화됩니다.</p>
						                    <span class="loader" style="display:none; margin: 10px;"><img src="/design2/img/ajax-loader.gif"></span>
						                </div>
						            </dd>
						        </dl>
						    </div>
						    <!-- 엑셀 밀어넣기 API -->
						    <div class="list_table mgt10 mgb15">
						        <div class="excel-menu-area">
						            <div id="count-div" class="excel-count">
						                <span><strong><span data-langcode="ADMININVITE022">전체 :</span><span id="all-count"> 0</span><span data-langcode="ADMININVITE023"></span></strong></span>
						                <span>(<span data-langcode="ADMININVITE024">등록 가능 : </span>
						                    <span id="posible-count">0</span>,
											<span data-langcode="ADMININVITE025">등록 불가 : </span>
						                    <span style="color:red;">
												<span id="err-count">0</span></span></span>)
						                
						                <label class="impossible-line-view"><input id="errorRowCheckBox" type="checkbox"> <span data-langcode="ADMININVITE011">등록 불가능한 행 모아보기</span></label>
						            </div>
						            <div class="excel-menu">
						                <button id="addDvsnCell" class="btn btn_style1" data-langcode="ADMININVITE012">행 추가</button>
						                <button id="removeDvsnCell" class="btn btn_style1" data-langcode="H381">삭제</button>
						                <button id="submitDvsnExcel" class="btn btn_style1 bgblue" data-langcode="ADMININVITE013">등록</button>
						            </div>
						        </div>
						        <table id="excel-list-header" cellpadding="0" cellspacing="0">
						            <caption></caption>
						            <colgroup>
						                <col>
						                <col>
						                <col>
						                <col>
						            </colgroup>
						            <thead>
						            <tr id="excel-add-th" class="dvsn-excel-tr">
						                <th class="dvsn-excel-check-th" scope="col">
						                    <div><input id="dvsnThCheckBox" type="checkbox" data-checked="false"></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG020">부서코드</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="CB1244">부서명</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG021">상위부서코드</span></div>
						                </th>
						                <th scope="col">
						                    <div><span data-langcode="ORG022">순서</span></div>
						                </th>
						            </tr>
						            </thead>
						        </table>
						        <!-- scroll -->
						        <div id="excel-scroll" class="scrollbox" style="">
						            <table cellpadding="0" cellspacing="0">
						                <caption></caption>
						                <colgroup>
						                </colgroup>
						                <tbody id="excelDataList"></tbody>
						            </table>
						        </div>
						        <!-- //scroll -->
						    </div>
						</div>
						

                </span>
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
                
<span id="접속_통계" class="left_menu" style="display :none;">
	<!-- 대타이틀 -->
	<div class="titleh1_style">
		<div>
			<h1 id="flow-acces-stat-title">접속 통계</h1>
		</div>
	</div>
	<!-- //대타이틀 -->
	<!-- 타이틀 -->
	<div class="titleh2_style mgt30">
		
		
		
	
		<div id="MONTHUseStat"><h2 data-langcode="FA1392">
			월별 통계 차트</h2> <!--월별 통계 차트-->
			<span data-langcode="FA1393">최근 6개월</span></div> <!--최근 6개월 -->
		<div id="WEEKUseStat" style="display:none;"><h2 data-langcode="FA1394">
			주별 통계 차트</h2> <!--주별 통계 차트-->
			<span data-langcode="FA1395">최근 10주</span></div> <!--최근 10주 -->
		<div id="DAILYUseStat" style="display:none;"><h2 data-langcode="FA1394">
			일별 통계 차트</h2> <!--일별 통계 차트-->
			<span data-langcode="FA1395">최근 30일</span></div> <!--최근 30일 -->
	</div>
	<!-- //타이틀 -->
	<!-- tab1_style -->
	<div id="HEAD-TAB" class="tab1_style mgt20">
		<a id="MONTH_TAB" data="MONTH" class="on" data-langcode="FA1396">월별</a>
		<a id="WEEK_TAB" data="WEEK" class="off" data-langcode="FA1397">주별</a>
		<a id="DAILY_TAB" data="DAILY" class="off" data-langcode="FA1397">일별</a>
	</div>
	<!-- //tab1_style -->
	<!-- 리스트테이블 -->
	<div id="MONTHChart" style="width: 100%; position: relative; user-select: none;" unselectable="on"><svg width="100%" height="400" buffered-rendering="dynamic" style="font-family:arial,Tahoma,verdana,jennifer;background:#fff"><g transform="translate(0.5,0.5)"><defs><clipPath id="clip-id--1686910848726-18"><rect x="0" y="0" width="1020" height="300"></rect></clipPath><clipPath id="clip-rect-id--1686910848726-16"><rect x="0" y="0" width="1020" height="300"></rect></clipPath></defs><rect rx="0" ry="0" fill="#fff" fill-opacity="0" stroke="#fff" stroke-width="0" width="1020" height="300" x="0" y="0" transform="translate(50,50)"></rect><g class="grid-block" transform="translate(50,350)"><g transform="translate(0,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 1월</text></g><g transform="translate(170,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 2월</text></g><g transform="translate(340,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 3월</text></g><g transform="translate(510,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 4월</text></g><g transform="translate(680,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 5월</text></g><g transform="translate(850,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line><text x="85" y="13" dy="3.6666666666666665" fill="#333" text-anchor="middle" font-size="11" font-weight="normal">2023 6월</text></g><line x1="0" y1="0" x2="1020" y2="0" stroke="#bfbfbf" stroke-width="2" stroke-opacity="1"></line><g transform="translate(1020,0)"><line x1="0" y1="0" x2="0" y2="3" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><line x1="0" y1="0" x2="0" y2="-300" stroke="#ebebeb" stroke-width="1" stroke-dasharray="none" stroke-opacity="1"></line></g></g><g transform="translate(50,50)"></g><g class="grid-range" transform="translate(50,50)"><g transform="translate(0,0)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">4</text></g><g transform="translate(0,37.5)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">3.5</text></g><g transform="translate(0,75)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">3</text></g><g transform="translate(0,112.5)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">2.5</text></g><g transform="translate(0,150)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">2</text></g><g transform="translate(0,187.5)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">1.5</text></g><g transform="translate(0,225)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">1</text></g><g transform="translate(0,262.5)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">0.5</text></g><g transform="translate(0,300)"><line x1="0" y1="0" x2="-3" y2="0" stroke="#bfbfbf" stroke-width="1.5" stroke-dasharray="none" stroke-opacity="1"></line><text x="-8" y="0" dy="3.6666666666666665" fill="#333" text-anchor="end" font-size="11" font-weight="normal">0</text></g><line x1="0" y1="0" x2="0" y2="300" stroke="#bfbfbf" stroke-width="2" stroke-opacity="1"></line></g><g transform="translate(50,50)"></g><g display="none" class="grid-panel" transform="translate(50,50)"><rect x="0" y="0" width="1020" height="300" fill="transparent" stroke="transparent"></rect></g><g clip-path="url(#clip-id--1686910848726-18)" class="brush-line" transform="translate(50,50)"><g><path stroke-opacity="1" stroke="#7977C2" x1="85" stroke-width="2" stroke-dasharray="none" fill="transparent" cursor="normal" style="pointer-events:stroke" x2="935" d="M85,300 L255,300 L425,300 L595,300 L765,300 L935,75"></path></g></g><g class="brush-scatter" transform="translate(50,50)"><ellipse rx="7.5" ry="7.5" cx="85" cy="300" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><ellipse rx="7.5" ry="7.5" cx="255" cy="300" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><ellipse rx="7.5" ry="7.5" cx="425" cy="300" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><ellipse rx="7.5" ry="7.5" cx="595" cy="300" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><ellipse rx="7.5" ry="7.5" cx="765" cy="300" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><ellipse rx="7.5" ry="7.5" cx="935" cy="75" opacity="1" fill="#7977C2" stroke="#fff" stroke-width="1"></ellipse><text y="-15" text-anchor="middle" fill="#333" font-size="11" font-weight="bold" opacity="1" transform="translate(0,0)"></text></g></g><g transform="translate(0.5,0.5)"></g></svg></div>
	<div id="WEEKChart" style=" display:none; width:100%;"></div>
	<div id="DAILYChart" style=" display:none; width:100%;"></div>
	<!-- //리스트테이블 -->
	<!-- 타이틀 -->
	<div class="titleh2_style_nobar mgt30">
		<div id="MONTHConnStat">
		<table cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td>
					<select id="month_gubun_select" style="width:100px; cursor:pointer;">
						<option value="0" data-langcode="H331">이름</option>
						<option value="1" data-langcode="FA1399">부서</option>
						<option value="2" data-langcode="CB1248">직책</option>
						<!-- 마드라스체크만 사용! -->
						
					</select>
					<input id="month_stat_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:200px;" data-langcode="FA1401">
					<a style="cursor:pointer" id="monthSearch" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>&nbsp;&nbsp;
					<label><input id="month_catg_active" type="checkbox" checked="">&nbsp;<span data-langcode="FA1403">접속자</span></label>&nbsp;&nbsp;
					<label><input id="month_catg_inactive" type="checkbox">&nbsp;<span data-langcode="FA1404">비접속자</span></label>
	                </td>
	            </tr>
	        </tbody></table>
	        <div class="right">
				<button id="ACCESExcel_MONTH" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
				<select id="month_select" style="width:100px; cursor:pointer;">
				<option value="0">2023 6월</option><option value="1">2023 5월</option><option value="2">2023 4월</option><option value="3">2023 3월</option><option value="4">2023 2월</option><option value="5">2023 1월</option></select>
			</div>
	
		</div>
		<div id="WEEKConnStat" style="display:none;">
		<table cellpadding="0" cellspacing="0">
			<tbody><tr>
				<td>
					<select id="week_gubun_select" style="width:100px; cursor:pointer;">
						<option value="0" data-langcode="H331">이름</option>
						<option value="1" data-langcode="FA1399">부서</option>
						<option value="2" data-langcode="CB1248">직책</option>
	                        <!-- 마드라스체크만 사용! -->
						
	                    </select>
	
					<input id="week_stat_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:200px;" data-langcode="FA1401">
					<a style="cursor:pointer" id="weekSearch" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>&nbsp;&nbsp;
				<label><input id="week_catg_active" type="checkbox" checked="">&nbsp;<span data-langcode="FA1403">접속자</span></label>&nbsp;&nbsp;
				<label><input id="week_catg_inactive" type="checkbox">&nbsp;<span data-langcode="FA1404">비접속자</span></label>
	                </td>
	            </tr>
	        </tbody></table>
	        <div class="right">
				<button id="ACCESExcel_WEEK" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
				<select id="week_select" style="width:100px; cursor:pointer;">
	            </select>
	        </div>
	    </div>
	    <div id="DAILYConnStat" style="display:none;">
	        <table cellpadding="0" cellspacing="0">
	            <tbody><tr>
	                <td>
						<select id="daily_gubun_select" style="width:100px; cursor:pointer;">
							<option value="0" data-langcode="H331">이름</option>
							<option value="1" data-langcode="FA1399">부서</option>
							<option value="2" data-langcode="CB1248">직책</option>
	                    </select>
	
						<input id="daily_stat_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:200px;" data-langcode="FA1401">
						<a style="cursor:pointer" id="dailySearch" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>&nbsp;&nbsp;
						<label><input id="daily_catg_active" type="checkbox" checked="">&nbsp;<span data-langcode="FA1403">접속자</span></label>&nbsp;&nbsp;
						<label><input id="daily_catg_inactive" type="checkbox">&nbsp;<span data-langcode="FA1404">비접속자</span></label>
	                </td>
	            </tr>
	        </tbody></table>
	        <div class="right">
				<button id="ACCESExcel_DAILY" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
				<select id="daily_select" style="width:100px; cursor:pointer;">
	            </select>
	        </div>
	    </div>
	
	</div>
	<!-- //타이틀 -->
	<!-- 리스트테이블 -->
	<div style="position:relative;">
	    <div class="list_table mgt10 mgb15" id="MONTH_TABLE">
	        <table cellpadding="0" cellspacing="0">
	            <caption></caption>
	            <thead>
	            <tr>
						<th scope="col" style="width: 7%;" id="company_name_th"><div data-langcode="H330">회사</div></th>
						<th scope="col" style="width: 10%;"><div data-langcode="H331">이름</div></th>
						<th scope="col" style="width: 15%;"><div data-langcode="FA1399">부서</div></th>
						<th scope="col" style="width: 8%;"><div data-langcode="CB1248">직책</div></th>
						<th scope="col" style="width: 15%;"><div data-langcode="FA1753">계정</div></th>
						<th scope="col" style="width: 15%;"><div data-langcode="FA1409">Desktop 접속수</div></th> <!-- 이번달 Desktop접속수 -->
						<th scope="col" style="width: 15%;"><div data-langcode="FA1410">Mobile 접속수</div></th> <!-- 이번달 Mobile 접속수 -->
						<th scope="col" style="width: 15%;"><div data-langcode="FA1411">총 접속수</div></th> <!-- 이번달 접속수 -->
	            </tr>
	            </thead>
	        </table>
	        <div id="monthScroll" class="scrollbox" style="">
	            <table cellpadding="0" cellspacing="0">
	                <caption></caption>
	                <colgroup>
	                    <col id="company_name_col" style="">
	                    <col style="width: 10%;">
	                    <col style="width: 15%;">
	                    <col style="width: 8%;">
	                    <col style="width: 15%;">
	                    <col style="width: 15%">
	                    <col style="width: 15%">
	                    <col style="width: 15%">
	                </colgroup>
	                <tbody><tr><td>오하늘닷컴</td><td>박형근</td><td></td><td></td><td>hkbk00@gmail.com</td><td>2</td><td>0</td><td>2</td></tr><tr><td>오하늘닷컴</td><td>정택인</td><td></td><td></td><td>brotaek@naver.com</td><td>4</td><td>0</td><td>4</td></tr><tr><td>오하늘닷컴</td><td>하늘하하늘</td><td></td><td></td><td>apzkemfht@proton.me</td><td>3</td><td>0</td><td>3</td></tr></tbody>
	            </table>
	        </div>
	    </div>
	    <div class="list_table mgt10 mgb15" id="WEEK_TABLE" style="display:none;">
	        <table cellpadding="0" cellspacing="0">
	            <caption></caption>
	            <thead>
	            <tr>
						<th scope="col" style="width: 7%;" id="week_company_name_th"><div><span data-langcode="H331">회사</span></div></th>
						<th scope="col" style="width: 10%;"><div data-langcode="H331">이름</div></th>
						<th scope="col" style="width: 15%;"><div data-langcode="FA1399">부서</div></th>
						<th scope="col" style="width: 8%;"><div data-langcode="CB1248">직책</div></th>
						<th scope="col" style="width: 15%;"><div data-langcode="FA1753">계정</div></th>
	                    <th scope="col" style="width: 15%;"><div data-langcode="FA1409">Desktop 접속수</div></th> <!-- 이번달 Desktop접속수 -->
	                    <th scope="col" style="width: 15%;"><div data-langcode="FA1410">Mobile 접속수</div></th> <!-- 이번달 Mobile 접속수 -->
	                    <th scope="col" style="width: 15%;"><div data-langcode="FA1411">총 접속수</div></th> <!-- 이번달 접속수 -->
	            </tr>
	            </thead>
	            <tbody>
	            </tbody>
	        </table>
	    </div>
	</div>
	
	<div class="list_table mgt10 mgb15" id="DAILY_TABLE" style="display:none;">
	    <table cellpadding="0" cellspacing="0">
	        <caption></caption>
	        <thead>
	        <tr>
					<th scope="col" style="width: 7%;" id="daily_company_name_th"><div><span data-langcode="H331">회사</span></div></th>
					<th scope="col" style="width: 10%;"><div data-langcode="H331">이름</div></th>
					<th scope="col" style="width: 15%;"><div data-langcode="FA1399">부서</div></th>
					<th scope="col" style="width: 8%;"><div data-langcode="CB1248">직책</div></th>
					<th scope="col" style="width: 15%;"><div data-langcode="FA1753">계정</div></th>
	                <th scope="col" style="width: 15%;"><div data-langcode="FA1409">오늘 Desktop 접속수</div></th> <!-- 이번달 Desktop접속수 -->
	                <th scope="col" style="width: 15%;"><div data-langcode="FA1410">오늘 Mobile 접속수</div></th> <!-- 이번달 Mobile 접속수 -->
	                <th scope="col" style="width: 15%;"><div data-langcode="FA1411">오늘 총 접속수</div></th> <!-- 이번달 접속수 -->
	        </tr>
	        </thead>
	    </table>
	    <div id="dailyScroll" class="scrollbox" style="">
	        <table cellpadding="0" cellspacing="0">
	            <caption></caption>
	            <colgroup>
	                <col id="daily_company_name_col" style="">
	                <col style="width: 10%;">
	                <col style="width: 15%;">
	                <col style="width: 8%;">
	                <col style="width: 15%;">
	                <col style="width: 15%">
	                <col style="width: 15%">
	                <col style="width: 15%">
	            </colgroup>
	            <tbody id="list">
	            </tbody>
	        </table>
	    </div>
	</div>
</span>
                
                
                
                
                
                
                
                
                
                
                
<span id="파일_보안_설정" class="left_menu" style="display: none;">
	<div id="flow-file-security" class="file-security-wrap new-security-wrap">
	    <h1>파일 보안 설정
	        <a class="help-link" href="https://support.flow.team/hc/ko/articles/16545568998041" target="_blank" rel="noopener noreferrer">
	            도움말
	        </a>
	    </h1>
	    <div class="main-wrap">
	        <div class="div-title">PC 권한
	            <button class="button-info js-mouseover" mouseover-text="컴퓨터 및 노트북을 통한 파일 접근을 제한합니다.">i</button>
	        </div>
	
	        <h2>
	            <span>지정된 IP에서만 다운로드 허용</span>
	            <div class="button-wrap">
	                <label class="switch-35" for="cbPcLimitDownload">
	                    <input type="checkbox" id="cbPcLimitDownload">
	                    <span class="btn-switch">
	                        <span></span>
	                    </span>
	                </label>
	            </div>
	        </h2>
	
	        <div class="sub-button-wrap">
	            <span>등록된 IP는 이미지·파일 다운로드가 가능합니다. 이외 모든 IP는 뷰어로 조회만 가능합니다.</span>
	            <div class="button-wrap">
	                <button id="btnCreateAllowIp" class="button-blue">
	                    + IP 추가
	                </button>
	            </div>
	        </div>
	        <div class="table-wrap author-table-wrap">
	            <table id="tblAllowIp">
	                <colgroup>
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: 40px;">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th>IP주소</th>
	                    <th>설명</th>
	                    <th>업데이트</th>
	                    <th>생성 ID</th>
	                    <th></th>
	                </tr>
	                </thead>
	                <tbody><tr class="table-null-wrap"><td colspan="5">ip주소를 입력해주세요</td></tr></tbody>
	            </table>
	        </div>
	        <div class="info-wrap">
	            <ul>
	                <li>뷰어로 조회가 불가능한 파일 확장자(exe 파일, ai 파일, zip파일 등)의 경우, 파일을 확인할 수 없게 됩니다.
	                    <button class="button-info js-mouseover" mouseover-text="특정 확장자 파일은 왜 확인이 불가한가요?<br>뷰어로 조회 불가능한 확장자 파일은 자동 다운로드 처리되어 파일을 확인하게 됩니다.<br>다운로드를 제한하게 되면 파일을 열어볼 수 없어 확인이 불가합니다.">i</button>
	                </li>
	                <li>오하늘닷컴 사용자가 업로드한 이미지·파일에만 적용됩니다.</li>
	                <li>IP 등록 없이 활성화 시 모든 IP에서 이미지·파일 다운로드가 불가합니다.</li>
	            </ul>
	        </div>
	
	        <div id="pcReadonlyWrap" class="d-none" style="display: none;">
	            <h2>
	                <span>이미지 파일 조회 제한</span>
	            </h2>
	            <div class="sub-wrap">
	                <ul>
	                    <li>
	                        <span>허용된 IP에서만 이미지·파일을 조회 할 수 있습니다.</span>
	                        <div class="button-wrap">
	                            <label class="switch-35" for="cbPcReadonlyAllowIp">
	                                <input type="checkbox" id="cbPcReadonlyAllowIp">
	                                <span class="btn-switch">
	                                <span></span>
	                            </span>
	                            </label>
	                        </div>
	                    </li>
	                    <li>
	                        <span>우리회사 직원만 이미지·파일 조회를 허용합니다.</span>
	                        <span class="applyWithMobileBadge" style="display: none">
	                            모바일 동시 적용
	                        </span>
	                        <div class="button-wrap">
	                            <label class="switch-35" for="cbReadonlyOurCorp">
	                                <input type="checkbox" id="cbReadonlyOurCorp">
	                                <span class="btn-switch">
	                                <span></span>
	                            </span>
	                            </label>
	                        </div>
	                    </li>
	                </ul>
	            </div>
	            <div class="info-wrap">
	                <ul>
	                    <li>2가지 모두 활성화 시 허용된 IP에서 우리회사 직원 계정만 이미지·파일 조회가 가능합니다.</li>
	                    <li>오하늘닷컴 사용자가 업로드한 이미지·파일의 조회 권한을 제한합니다.</li>
	                </ul>
	            </div>
	        </div>
	    </div>
	
	    <div class="main-wrap">
	        <div class="div-title">모바일 권한
	            <button class="button-info js-mouseover" mouseover-text="안드로이드 및 iOS의 플로우 앱을 통한 파일 접근을 제한합니다.">i</button>
	        </div>
	        <h2>
	            <span>이미지·파일 다운로드 제한</span>
	            <div class="button-wrap">
	                <label class="switch-35" for="cbMbLimitDownload">
	                    <input type="checkbox" id="cbMbLimitDownload">
	                    <span class="btn-switch">
	                        <span></span>
	                    </span>
	                </label>
	            </div>
	        </h2>
	        <div class="sub-button-wrap">
	            <span>
	                활성화 시 오하늘닷컴 사용자가 업로드한 이미지·파일은 다운로드가 불가하며 뷰어로 조회만 가능합니다.
	            </span>
	        </div>
	        <div id="mbReadonlyWrap" class="d-none" style="display: none;">
	            <h2>
	                <span>이미지·파일 조회 제한</span>
	                <div class="button-wrap">
	                    <label class="switch-35" for="cbMbLimitRead">
	                        <input type="checkbox" id="cbMbLimitRead">
	                        <span class="btn-switch">
	                        <span></span>
	                    </span>
	                    </label>
	                </div>
	            </h2>
	            <div class="sub-button-wrap">
	                <span>모바일에서는 이미지·파일 조회가 불가합니다.</span>
	            </div>
	        </div>
	        <div class="info-wrap">
	            <ul>
	                <li>
	                   	활성화 시 문서 뷰어 조회가 불가능한 파일 확장자 (ex. exe 파일, ai 파일, zip파일 등)은 
						직원이 다운로드 할 수 없어 확인이 불가 합니다.
	                    <button class="button-info js-mouseover" mouseover-text="특정 확장자 파일은 왜 확인이 불가한가요?<br>뷰어로 조회 불가능한 확장자 파일은 자동 다운로드 처리되어 파일을 확인하게 됩니다.<br>
						다운로드를 제한하게 되면 파일을 열어볼 수 없어 확인이 불가합니다.">i
						</button>
	                </li>
	                <li>
	                  	모바일에서는 IP로 파일 접근 제한이 불가합니다.
	                    <button class="button-info js-mouseover" mouseover-text="모바일 통신망은 유동 IP를 사용하기 때문에 특정 IP로 제한하는 것이 어렵습니다.">i</button>
	                </li>
	            </ul>
	        </div>
	    </div>
	
	    <div class="main-wrap">
	        <div class="div-title">파일 권한 예외 유저 관리
	            <div class="button-wrap">
	                <label class="switch-35" for="cbAccessAllowUser">
	                    <input type="checkbox" id="cbAccessAllowUser">
	                    <span class="btn-switch">
	                        <span></span>
	                    </span>
	                </label>
	            </div>
	        </div>
	
	        <div class="sub-button-wrap">
	            <span>추가된 유저는 어디서든 파일 조회 / 다운로드가 가능합니다. (PC, 모바일 동시적용)</span>
	            <div class="button-wrap">
	                <button id="btnRemoveAllowUser" class="button-light">삭제</button>
	                <button id="btnCreateAllowUser" class="button-blue">추가</button>
	            </div>
	        </div>
	        <div class="table-wrap chk-table-wrap">
	            <table id="tblAllowUser">
	                <colgroup>
	                    <col style="width: 40px;">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                    <col style="width: calc(25% - 10px);">
	                </colgroup>
	                <thead>
	                <tr>
	                    <th><input id="cbSelectAllowUserAll" type="checkbox"></th>
	                    <th>허용 IP</th>
	                    <th>사용자 이름</th>
	                    <th>업데이트</th>
	                    <th>생성 ID</th>
	                </tr>
	                </thead>
	                <tbody><tr class="table-null-wrap"><td colspan="5">예외 유저가 없습니다.</td></tr></tbody>
	            </table>
	        </div>
	    </div>
	    <div id="allowIpModalWrap">
	        <div id="allowIpModal" class="file-security-allow-ip-modal d-none">
	            <div class="allow-ip-modal-container">
	                <header>
	                    <h4>IP 추가</h4>
	                    <input type="button" class="pop_close" title="닫기" style="cursor:pointer;">
	                </header>
	                <section>
	                    <div class="modal-input-wrap">
	                        <div class="modal-input-label">IP주소*</div>
	                        <div style="width: calc(100% - 220px);" class="allow-ip-input-wrap">
	                            <input type="text" class="js-allow-ip-input" data-idx="1" placeholder="000" maxlength="3">
	                            <span>.</span>
	                            <input type="text" class="js-allow-ip-input" data-idx="2" placeholder="000" maxlength="3">
	                            <span>.</span>
	                            <input type="text" class="js-allow-ip-input" data-idx="3" placeholder="000" maxlength="3">
	                            <span>.</span>
	                            <input type="text" class="js-allow-ip-input" data-idx="4" placeholder="000" maxlength="3">
	                        </div>
	                        <div id="getCurrentIp" class="modal-input-link">
	                            <a href="#">현재 IP 불러오기</a>
	                            <div class="d-none">
				        <svg class="rotating" width="21" height="20" viewBox="0 0 21 20" fill="none" xmlns="http://www.w3.org/2000/svg">
				            <path d="M10.5 6.46C12.1 6.46 13.4 5.16 13.4 3.57C13.4 1.97 12.1 0.68 10.5 0.68C8.91 0.68 7.62 1.97 7.62 3.57C7.62 5.16 8.91 6.46 10.5 6.46Z" fill="#00B2FF"></path>
				            <path opacity="0.2" d="M3.51 11.5C5.1 11.5 6.4 10.21 6.4 8.62C6.4 7.02 5.1 5.73 3.51 5.73C1.91 5.73 0.62 7.02 0.62 8.62C0.62 10.21 1.91 11.5 3.51 11.5Z" fill="#777"></path>
				            <path opacity="0.2" d="M6.19 19.68C7.78 19.68 9.07 18.39 9.07 16.79C9.07 15.2 7.78 13.9 6.19 13.9C4.59 13.9 3.3 15.2 3.3 16.79C3.3 18.39 4.59 19.68 6.19 19.68Z" fill="#402A9D"></path>
				            <path d="M14.84 19.68C16.43 19.68 17.72 18.39 17.72 16.79C17.72 15.2 16.43 13.9 14.84 13.9C13.24 13.9 11.95 15.2 11.95 16.79C11.95 18.39 13.24 19.68 14.84 19.68Z" fill="#FD7900"></path>
				            <path d="M17.52 11.5C19.11 11.5 20.4 10.21 20.4 8.62C20.4 7.02 19.11 5.73 17.52 5.73C15.92 5.73 14.63 7.02 14.63 8.62C14.63 10.21 15.92 11.5 17.52 11.5Z" fill="#00B01C"></path>
				        </svg>
			        </div>
	                        </div>
	                    </div>
	                    <div class="modal-input-wrap">
	                        <div class="modal-input-label">설명</div>
	                        <div style="width: calc(100% - 100px)">
	                            <input type="text" id="allowIpDesc" class="w100" maxlength="100" placeholder="IP 주소의 설명을 작성해 주세요.">
	                        </div>
	                    </div>
	                </section>
	                <footer class="button-wrap">
	                    <button id="saveAllowIp" class="plusbtn_style btn_blue2">저장</button>
	                    <button class="plusbtn_style pop_close">취소</button>
	                </footer>
	            </div>
	            <div class="dimmed"></div>
	        </div>
	    </div>
	</div>
</span>
                
                
                
                
                
                
                
                
                
                
                
<span id="로그인_보안_설정" class="left_menu" style="display: none;">
	<div id="flow-login-security" class="login-security-wrap new-security-wrap">
	    <h1>로그인 보안 설정
	        <a class="help-link" href="https://support.flow.team/hc/ko/articles/16546376528281" target="_blank" rel="noopener noreferrer">
	            도움말
	        </a>
	    </h1>
	
	    <div class="main-wrap">
	        <div class="div-title">
	            로그인 2차 인증
	            <div class="button-wrap">
	                <label class="switch-35" for="twoFactorToggle">
	                    <input type="checkbox" id="twoFactorToggle">
	                    <span class="btn-switch">
	                        <span></span>
	                    </span>
	                </label>
	            </div>
	        </div>
	        <div class="sub-button-wrap">
	            <span>2차 인증 설정 시,확인되지 않은 휴대폰이나 컴퓨터에서 로그인할 때 인증번호를 요구합니다.</span>
	        </div>
	        <div class="info-wrap">
	            <ul>
	                <li>모든 직원은 로그인 시 등록된 이메일 주소 혹은 휴대폰 번호로 인증번호를 받게 됩니다.</li>
	                <li>2차 인증 설정 후, 신규 로그인된 장치부터 2차 인증이 적용됩니다 (기존 로그인된 장치는 적용 안됨)</li>
	                <li>재인증이 필요한 경우, [어드민 &gt; 구성원 관리] 메뉴에서 사용자별 [접속 장치] 초기화하여 가능합니다</li>
	            </ul>
	        </div>
	    </div>
	
	    <div class="main-wrap">
	        <div class="div-title">중복 로그인 방지
	            <div class="button-wrap">
	                <label class="switch-35" for="cbDuplLoginLimit">
	                    <input type="checkbox" id="cbDuplLoginLimit">
	                    <span class="btn-switch">
	                        <span></span>
	                    </span>
	                </label>
	            </div>
	        </div>
	        <div class="sub-button-wrap">
	            <span>다른 장치에 접속된 계정은 자동 로그아웃 됩니다.</span>
	        </div>
	        <div class="info-wrap">
	            <ul>
	                <li>중복 로그인 방지' 옵션 설정 시, 웹, 모바일, 태블릿, 데스크탑 각 기기별  1개의 장치에서만 로그인할 수 있도록 설정됩니다.</li>
	                <li>마지막에 접속된 장치만 로그인 유지되며 그외에는 모두 로그아웃 처리됩니다</li>
	            </ul>
	        </div>
	    </div>
	</div>
</span>
                
                
                
                
<span id="관리자_변경_이력" class="left_menu" style="display: none;">
                    










<!-- 대타이틀 -->
<div class="titleh1_style">
	<div>
		<h1 id="flow-edit-log-title">관리자 변경 이력</h1>
	</div>
</div>
<!-- //대타이틀 -->

<!-- tab1_style -->
<div id="HEAD-TAB" class="tab1_style mgt30">
	<a id="EDIT_LOG_TAB" class="on" data-langcode="FA1511">변경 이력</a>
</div>

<div id="EDIT_LOG_SEARCH" class="titleh2_style" style="margin-top:15px; margin-bottom:15px;">
	<table cellpadding="0" cellspacing="0">
		<colgroup>
			<col style="width:110px;"><col style="width:230px;">
			<col style="width:110px;"><col style="width:310px;">
		</colgroup>
		<tbody><tr>
			<th scope="row">
				<select id="edit_log_search_gubun" style="width:100px;">
					<option value="1" data-langcode="FA1518">변경자</option>
					<option value="2">ID</option>
					<option value="3" data-langcode="FA1512">메뉴</option>
					<option value="4" data-langcode="FA1513">기능</option>
				</select>
			</th>
			<td>
				<input id="edit_log_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:190px;" data-langcode="FA1754">
			</td>
			<th scope="row">
			</th>
			<td>
				<input type="text" id="EDIT_LOG_SCHD_STTG_DT" class="SCHD_STTG_DT" style="width:130px;" autocomplete="off" sttg_dt="20230110">
				<input type="text" id="EDIT_LOG_SCHD_FNSH_DT" class="SCHD_FNSH_DT" style="width:130px;" autocomplete="off" fnsh_dt="20230710210412">
			</td>
			<td><a id="EDIT_LOG_SRCH_BTN" class="btn srchbtn_style" data-langcode="AA0009">검색</a></td>
		</tr>
	</tbody></table>
	<div class="right">
		<button id="EDIT_LOG_EXCEL" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
	</div>
</div>
<!-- //검색테이블 -->

<div id="EDIT_LOG_TABLE" class="list_table mgt10 mgb15">
	<table cellpadding="0" cellspacing="0">
		<caption></caption>
		<thead>
			<tr>
				<th scope="col"><div data-langcode="FA1519">변경자(ID)</div></th>
				<th scope="col"><div data-langcode="FA1512">메뉴</div></th>
				<th scope="col"><div data-langcode="FA1513">기능</div></th>
				<th scope="col"><div data-langcode="FA1515">대상(프로젝트명, 사용자)</div></th>
				<th scope="col"><div data-langcode="FA1522">변경사항</div></th>
				<th scope="col" style="width:110px"><div data-langcode="FA1517">변경일시</div></th>
			</tr>
		</thead>
	</table>
	<!-- scroll -->
	<div id="editLogScrollContentWrap" class="scrollbox">
		<table cellpadding="0" cellspacing="0">
			<tbody><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>사용자 등록</td><td>정캑인(apzkemfht@asdasd.com)</td><td></td><td style="width: 110px;">2023-07-06, 16:29</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>계정 삭제</td><td>정캑인(apzkemfht@asdasd.com)</td><td>계정 삭제</td><td style="width: 110px;">2023-07-06, 16:28</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>정캑인(apzkemfht@asdasd.com)</td><td></td><td style="width: 110px;">2023-07-06, 16:28</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정캑인(apzkemfht@asdasd.com)</td><td></td><td style="width: 110px;">2023-07-06, 16:28</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정캑인(apzkemfht@asdasd.com)</td><td></td><td style="width: 110px;">2023-07-06, 16:28</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>사용자 등록</td><td>정캑인(apzkemfht@asdasd.com)</td><td></td><td style="width: 110px;">2023-07-06, 16:27</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>2하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 15:58</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-06, 14:52</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>2하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>가입 승인</td><td>2하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:29</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>계정 삭제</td><td>이하늘2(apzkemfht34@proton.me)</td><td>계정 삭제</td><td style="width: 110px;">2023-07-06, 12:13</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:13</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:13</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:13</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 12:10</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 11:48</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 11:48</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 11:34</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 09:33</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-06, 09:33</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:58</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:58</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:57</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:57</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:57</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:57</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>가입 승인</td><td>이하늘2(apzkemfht34@proton.me)</td><td></td><td style="width: 110px;">2023-07-04, 16:57</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지 해제)</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:17</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>상태 변경(이용중지)</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-07-04, 15:17</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>접속 장치 해제</td><td>정택인(brotaek@naver.com)</td><td>PC-CHROME_334620-795-674-705238</td><td style="width: 110px;">2023-07-04, 15:07</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>접속 장치 해제</td><td>정택인(brotaek@naver.com)</td><td>PC-CHROME_983090-456-62-43605</td><td style="width: 110px;">2023-07-04, 15:07</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-07-04, 14:14</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>특정도메인의 이메일 바로 참여 'dddddddddd' → 관리자의 가입 승인 완료 후 참여</td><td style="width: 110px;">2023-07-04, 12:32</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>관리자의 가입 승인 완료 후 참여 → 특정도메인의 이메일 바로 참여 'dddddddddd'</td><td style="width: 110px;">2023-07-04, 11:44</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>특정도메인의 이메일 바로 참여 'aaaaa' → 관리자의 가입 승인 완료 후 참여</td><td style="width: 110px;">2023-07-04, 11:35</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>관리자의 가입 승인 완료 후 참여 → 특정도메인의 이메일 바로 참여 'aaaaa'</td><td style="width: 110px;">2023-07-04, 11:34</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'ASXX' → 'QQQQQZ'</td><td style="width: 110px;">2023-07-04, 10:18</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'XASXX' → 'ASXX'</td><td style="width: 110px;">2023-07-04, 10:18</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'ASXX' → 'XASXX'</td><td style="width: 110px;">2023-07-04, 10:18</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'5SKYSSDCC' → 'ASXX'</td><td style="width: 110px;">2023-07-04, 10:17</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'5SKYSS' → '5SKYSSDCC'</td><td style="width: 110px;">2023-07-04, 10:17</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>전용 URL</td><td></td><td>'5SKY' → '5SKYSS'</td><td style="width: 110px;">2023-07-04, 10:17</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사 프로젝트 관리</td><td>회사 프로젝트 등록</td><td>ssssssss(1868572)</td><td></td><td style="width: 110px;">2023-06-28, 16:48</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 카테고리 관리</td><td>카테고리 추가</td><td>dvdav</td><td></td><td style="width: 110px;">2023-06-28, 16:23</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 카테고리 관리</td><td>카테고리 추가</td><td>aaa</td><td></td><td style="width: 110px;">2023-06-28, 16:23</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>정택인(kakao_2739051431)</td><td style="width: 110px;">2023-06-28, 11:42</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 삭제</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 삭제</td><td>Yo!(1852542)</td><td>정택인(kakao_2739051431)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>정택인(kakao_2739051431)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 삭제</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 삭제</td><td>Yo!(1852542)</td><td>정택인(brotaek@naver.com)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 삭제</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 15:45</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>공개 프로젝트 관리</td><td>프로젝트 관리자 추가</td><td>Yo!(1852542)</td><td>하늘하하늘(apzkemfht@proton.me)</td><td style="width: 110px;">2023-06-27, 14:20</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>정택인(brotaek@naver.com)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>특정도메인의 이메일 바로 참여 '2222.com' → 관리자의 가입 승인 완료 후 참여</td><td style="width: 110px;">2023-06-27, 09:39</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>정택인(brotaek@naver.com)</td><td>회사정보</td><td>직원 참여 옵션 변경</td><td></td><td>관리자의 가입 승인 완료 후 참여 → 특정도메인의 이메일 바로 참여 '2222.com'</td><td style="width: 110px;">2023-06-27, 09:36</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>정택인(brotaek@naver.com)</td><td>회사정보</td><td>로고설정</td><td></td><td>로고 등록</td><td style="width: 110px;">2023-06-27, 09:26</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사정보</td><td>회사명 변경</td><td></td><td>'오!하늘닷컴' → '오하늘닷컴'</td><td style="width: 110px;">2023-06-27, 09:25</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>정택인(brotaek@naver.com)</td><td>회사정보</td><td>회사명 변경</td><td></td><td>'오하늘닷컴' → '오!하늘닷컴'</td><td style="width: 110px;">2023-06-27, 09:25</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사 프로젝트 관리</td><td>회사 프로젝트 등록</td><td>화사공(1866044)</td><td></td><td style="width: 110px;">2023-06-27, 09:23</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>정택인(brotaek@naver.com)</td><td>공개 프로젝트 카테고리 관리</td><td>카테고리 삭제</td><td>호호</td><td></td><td style="width: 110px;">2023-06-23, 14:42</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사 프로젝트 관리</td><td>회사 프로젝트 등록</td><td>두번째company프로젝트(1862990)</td><td></td><td style="width: 110px;">2023-06-23, 12:30</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>회사 프로젝트 관리</td><td>회사 프로젝트 등록</td><td>회사프로젝트(1862668)</td><td></td><td style="width: 110px;">2023-06-23, 10:05</td><td style="width: 100px;">106.249.191.7</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:42</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:40</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:40</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:40</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:40</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>%%%%%%%%%(hkbk00@gmail.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 해제</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr><tr><td>하늘하하늘(apzkemfht@proton.me)</td><td>사용자 관리</td><td>관리자 지정</td><td>정택인(brotaek@naver.com)</td><td></td><td style="width: 110px;">2023-06-21, 18:16</td><td style="width: 100px;">106.249.191.8</td></tr></tbody>
		</table>
	</div>
	<!-- //scroll -->
</div>
<!-- //리스트테이블 -->

                </span>   
                
                
                
                
                
                
                
<span id="파일_다운로드_이력" class="left_menu" style="display: none;">
	<!-- 대타이틀 -->
	<div class="titleh1_style">
		<div>
			<h1 id="flow-down-hstr-title">파일 다운로드 이력</h1>
		</div>
	</div>
	<!-- //대타이틀 -->
	
	<!-- 검색테이블 -->
	<div class="srch_table mgt10">
		<table cellpadding="0" cellspacing="0">
			<colgroup>
			<col style="width:110px;">
			<col style="width:230px;">
			<col style="width:110px;">
			<col style="width:350px;">
			</colgroup>
			<tbody><tr>
				<th scope="row">
					<select id="hstr_srch_catg" style="width:100px;">
						<option data-langcode="CLP1000">파일명</option>
						<option data-langcode="H331">이름</option>
						<option data-langcode="FL561">아이디</option>
					</select>
				</th>
				<td>
					<input id="down_hstr_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:190px;" data-langcode="CLP1000">
				</td>
				<th scope="row" class="table-th-ja">
						<label data-langcode="FA1499">다운로드 일시</label>
				</th>
				<td>
					<input type="text" id="DOWN_SCHD_STTG_DT" class="SCHD_STTG_DT hasDatepicker" style="width:150px;" autocomplete="off" sttg_dt="20221219">
					<input type="text" id="DOWN_SCHD_FNSH_DT" class="SCHD_FNSH_DT hasDatepicker" style="width:150px;" autocomplete="off" fnsh_dt="20230619000252">
				</td>
				<td id="excel-srch-bt-where">
					<a id="srch-file-bt" style="cursor:pointer" class="btn srchbtn_style" data-langcode="CPH1359">검색</a>
				</td>
			</tr>
		</tbody></table>
	</div>
	
	<!-- //검색테이블 -->
	
	<!-- 리스트테이블 -->
	<div id="down_hstr_list_table" class="list_table mgt10 mgb15">
		<table cellpadding="0" cellspacing="0">
			<caption></caption>
			<colgroup>
			<col style="">
			<col style="">
			<col style="">
			<col style="">
			<col style="">
			<!--
			<col style="">
			<col style="">
			 -->
			</colgroup>
			<thead>
				<tr>
					<th scope="col"><div><span data-langcode="FA1499">다운로드 일시</span><a style="cursor:pointer" class=""></a></div></th>
					<th scope="col"><div><span data-langcode="CLP1000">파일명</span><a style="cursor:pointer" class=""></a></div></th>
					<th scope="col"><div><span data-langcode="FA1501">용량</span><a style="cursor:pointer" class=""></a></div></th>
					<th scope="col"><div><span data-langcode="FA1502">이름/아이디</span><a style="cursor:pointer" class=""></a></div></th>
					<th scope="col"><div><span data-langcode="FA1503">장치</span><a style="cursor:pointer" class=""></a></div></th>
				</tr>
			</thead>
		</table>
		<!-- scroll -->
		<div id="hstr_scroll" class="scrollbox mCustomScrollbar _mCS_13 mCS-autoHide mCS_no_scrollbar" style="height:680px;"><div id="mCSB_13" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 679.333px;" tabindex="0"><div id="mCSB_13_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
			<table cellpadding="0" cellspacing="0">
				<caption></caption>
				<colgroup>
					<col style="">
					<col style="">
					<col style="">
					<col style="">
					<col style="">
				</colgroup>
				<tbody id="down_hstr_tbody"><tr><td>2023-06-16, 19:27</td><td style="text-align: left; padding-left: 10px;">어드민.css</td><td>144.65 KB</td><td>정택인(brotaek@naver.com)</td><td>&nbsp;<a class="tbold_uline">[보기]</a></td></tr><tr><td>2023-06-16, 09:15</td><td style="text-align: left; padding-left: 10px;">9_LM2001020225_화면구현_6월20일.pdf</td><td>11.83 MB</td><td>박형근(hkbk00@gmail.com)</td><td>&nbsp;<a class="tbold_uline">[보기]</a></td></tr></tbody>
			</table>
		</div><div id="mCSB_13_scrollbar_vertical" class="mCSB_scrollTools mCSB_13_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><a href="#" class="mCSB_buttonUp" oncontextmenu="return false;"></a><div class="mCSB_draggerContainer"><div id="mCSB_13_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px; height: 0px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div><a href="#" class="mCSB_buttonDown" oncontextmenu="return false;"></a></div></div></div>
		<!-- //scroll -->
	</div>
	<!-- //리스트테이블 -->
	
	
	
	<div id="downHstrDeviceLayer" class="bgmodal_wrap" style="display:none;">
		<div class="lyaer_popup_wrap" style="width:750px; max-height:530px;margin-top:-300px;margin-left:-375px;">
			<div class="lyaer_popup_top">
				<h1 data-langcode="AA0146">다운로드 장치 정보</h1>
				<input type="button" class="pop_close" title="닫기" style="cursor: pointer;">
			</div>
			<div class="lyaer_popup_cont">
				<!-- 리스트테이블 -->
				<div class="list_table mgt15">
					<table cellpadding="0" cellspacing="0">
						<caption></caption>
						<colgroup>
						<col style=";">
						<col style="width:25%;">
						<col style="width:25%;">
						</colgroup>
						<thead>
							<tr>
								<th scope="col"><div data-langcode="FA1388">장치명</div></th>
								<th scope="col"><div data-langcode="AA0128">타입</div></th>
								<th scope="col"><div data-langcode="FA1502">이름/아이디</div></th>
							</tr>
						</thead>
					</table>
					<!-- scroll -->
					<div id="deviceScroll" class="scrollbox " style="max-height: 385px;">
						<table cellpadding="0" cellspacing="0">
							<caption></caption>
							<colgroup>
							<col style=";">
							<col style="width:25%;">
							<col style="width:25%;">
							</colgroup>
							<tbody></tbody>
						</table>
					</div>
					<!-- //scroll -->
				</div>
				<!-- //리스트테이블 -->
			</div>
		</div>
	</div>
</span>





<span id="사용_통계" class="left_menu" style="display:none;">
                    









<!-- 대타이틀 -->
<div class="titleh1_style">
    <div>
        
        <h1 id="flow-use-stat-title">사용 통계</h1>
        
    </div>
</div>
<!-- //대타이틀 -->

<!-- tab1_style -->
<div id="HEAD-TAB" class="tab1_style mgt30">
    <!-- <a id="PROJECT_TAB" data="PROJECT" class="on" data-langcode="FA1744">프로젝트별</a> -->
    <a id="USER_TAB" data="USER" class="on" data-langcode="FA1745">사용자 별</a>
</div>
<!-- //tab1_style -->

<!-- 검색테이블 -->
<!--
<div id="PROJECT_SEARCH" class="titleh2_style" style="margin-top:15px; margin-bottom:15px">
<table cellpadding="0" cellspacing="0">
<colgroup>
<col style="width:310px;">
<col style="width:110px;">
<col style="width:310px;">
<col>
</colgroup>
<tr>
<td>
<input id="project_srch_word" type="text" placeholder="프로젝트명을 적어주세요" style="width:280px;" data-langcode="FA1441">
</td>
<th scope="row">
<select style="width:100px;">
<option data-langcode="FA1605">최근활동일</option>
</select>
</th>
<td>
<input type="text" id="USE_SCHD_STTG_DT" class="SCHD_STTG_DT" style="width:130px;" autocomplete="off">
<input type="text" id="USE_SCHD_FNSH_DT" class="SCHD_FNSH_DT" style="width:130px;" autocomplete="off">
</td>
<td><a id="PROJECT_SRCH_BTN" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
</tr>
</table>
<div class="right">
<button id="PROJECTExcel" class="btn_icodown" data-langcode="FA1415">엑셀내려받기</button>
</div>
</div>
-->
<div id="USER_SEARCH" class="titleh2_style" style="margin-top:15px; margin-bottom:15px;">
    <table cellpadding="0" cellspacing="0">
        <colgroup>
            <col style="width:110px;">
            <col style="width:230px;">
            <col style="width:110px;">
            <col style="width:310px;">
            <col>
        </colgroup>
        <tbody><tr>
            <th scope="row">
                <select id="USER_GUBUN" style="width:100px;">
                    <option value="0" data-langcode="H331">이름</option>
<!--                     <option value="1" data-langcode="FA1399">부서</option> -->
<!--                     <option value="2" data-langcode="CB1248">직책</option> -->
<!--                     <option value="3" data-langcode="FA1753">계정</option> -->
                    <!-- 마드라스체크만 사용! -->
                    
                </select>
            </th>
            <td>
                <input id="user_srch_word" type="text" placeholder="검색어를 입력해주세요" style="width:190px;" data-langcode="FA1754">
            </td>

            <!-- @임석현 [DB금투] 날짜 추가-->
                

            <td><a id="USER_SRCH_BTN" class="btn srchbtn_style" data-langcode="CPH1359">검색</a></td>
            <!-- @임석현 [DB금투] 끝 -->

        </tr>
    </tbody></table>
    <div class="right">
        <button id="USERExcel" class="btn_icodown" data-langcode="FA1415">엑셀 다운로드</button>
    </div>
</div>
<!-- //검색테이블 -->

<!-- 리스트테이블
<div id="PROJECT_TABLE" class="list_table mgt10 mgb15">
<table cellpadding="0" cellspacing="0">
<caption></caption>
<colgroup>
<col style="width:20%">
<col style="">
<col style="">
<col style="">
<col style="">
<col style="">
<col style="">
</colgroup>
<thead>
<tr>
<th scope="col"><div><span data-langcode="FL558">프로젝트</span><a data="TTL"></a></div></th>
<th scope="col"><div><span data-langcode="H420">관리자</span><a data="ADMIN" ></a></div></th>
<th scope="col"><div><span data-langcode="FA1602">참여자수</span><a data="JOIN_CNT" ></a></div></th>
<th scope="col"><div><span data-langcode="FA1438">게시물수</span><a data="PROJECT_CNT"></a></div></th>
<th scope="col"><div><span data-langcode="FA1439">댓글수</span><a data="REMARK_CNT"></a></div></th>
<th scope="col"><div><span data-langcode="FA1605">최근활동일</span><a data="EDTR_DTTM"></a></div></th>
<th scope="col"><div><span data-langcode="FA1760">개설일</span><a data="RGSN_DTTM"></a></div></th>
</tr>
</thead>
</table>


<div id="useStatPrjScroll" class="scrollbox" style="max-height: 600px;">
<table cellpadding="0" cellspacing="0">
<caption></caption>
<colgroup>
<col style="width:20%">
<col style="">
<col style="">
<col style="">
<col style="">
<col style="">
<col style="">
</colgroup>
<tbody>
<tr>
<td>웹 최신 디자인 트랜드 공유</td>
<td>130</td>
<td>130</td>
<td>2000</td>
<td>103</td>
<td>2018-01-01</td>
<td>2018-01-01</td>
</tr>
</tbody>
</table>
</div>
</div>
-->
<div id="USER_TABLE" class="list_table mgt10 mgb15">
    <table cellpadding="0" cellspacing="0">
        <caption></caption>
        <colgroup>
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            <col style="">
            
            <!--@임석현 [DB금투] 추가 -->
            
            
            
            <!--@임석현 [DB금투] 끝 -->
        </colgroup>
        <thead>
        <tr>
            <th scope="col">
                <div><span>회사</span></div>
            </th>
            <th scope="col">
                <div data-langcode="H331">이름</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1399">부서</div>
            </th>
            <th scope="col">
                <div data-langcode="CB1248">직책</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1753">계정</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1765">활동 프로젝트 수</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1438">게시물</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1439">댓글</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1768">채팅방</div>
            </th>
            <th scope="col">
                <div data-langcode="FA1769">채팅 메시지</div>
            </th>
            

            <!--@임석현 [DB금투] 추가 -->
            
            
            
            <!--@임석현 [DB금투] 끝 -->


        </tr>
        </thead>
    </table>
    <!-- scroll -->
    <div id="userScrollContentWrap" class="scrollbox">
        <table cellpadding="0" cellspacing="0">
            <caption></caption>
            <colgroup>
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">
                <col style="">

                <!--@임석현 [DB금투] 추가 -->
                
                
                
                <!--@임석현 [DB금투] 끝 -->
            </colgroup>
            <tbody><tr><td>오하늘닷컴</td><td>정캑인</td><td></td><td></td><td>apzkemfht@asdasd.com</td><td class="active-project-num">0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>오하늘닷컴</td><td>정택인</td><td></td><td></td><td>brotaek@naver.com</td><td class="active-project-num">1</td><td>1</td><td>2</td><td>0</td><td>0</td></tr><tr><td>오하늘닷컴</td><td>하늘하하늘</td><td></td><td></td><td>apzkemfht@proton.me</td><td class="active-project-num">1</td><td>0</td><td>0</td><td>0</td><td>0</td></tr><tr><td>오하늘닷컴</td><td>%%%%%%%%%</td><td></td><td>태긴태긴태태긴</td><td>hkbk00@gmail.com</td><td class="active-project-num">2</td><td>8</td><td>11</td><td>0</td><td>0</td></tr><tr><td>오하늘닷컴</td><td>2하늘2</td><td></td><td></td><td>apzkemfht34@proton.me</td><td class="active-project-num">0</td><td>0</td><td>0</td><td>0</td><td>0</td></tr></tbody>
        </table>
    </div>
    <!-- //scroll -->
</div>
<!-- //리스트테이블 -->


<div id="projectLayer" class="bgmodal_wrap" style="display:none;">
    <div class="lyaer_popup_wrap" style="width:750px; max-height:530px;margin-top:-300px;margin-left:-375px;">
        <div class="lyaer_popup_top">
            <h1>프로젝트 정보</h1>
            <input type="button" class="pop_close" title="닫기" style="cursor: pointer;">
        </div>
        <div class="lyaer_popup_cont">
            <!-- 리스트테이블 -->
            <div class="list_table mgt15">
                <table cellpadding="0" cellspacing="0">
                    <caption></caption>
                    <colgroup>
                        <col style=";">
                        <col style="width:25%;">
                    </colgroup>
                    <thead>
                    <tr>
                        <th scope="col">
                            <div>프로젝트명</div>
                        </th>
                        <th scope="col">
                            <div>참여자</div>
                        </th>
                    </tr>
                    </thead>
                </table>
                <!-- scroll -->
                <div id="projectLayerScroll" class="" style="max-height: 385px;">
                    <table cellpadding="0" cellspacing="0">
                        <caption></caption>
                        <colgroup>
                            <col style=";">
                            <col style="width:25%;">
                        </colgroup>
                        <tbody>
                        </tbody>
                    </table>
                </div>
                <!-- //scroll -->
            </div>
            <!-- //리스트테이블 -->
        </div>
    </div>
</div>

                </span>








<span id="결제_정보" class="left_menu" style="display: none;">
                    












<!-- 대타이틀 -->
<div class="titleh1_style">
	<div>
		<h1 id="flow-pay-info-title">결제 정보</h1>
		
	</div>
</div>
<!-- //대타이틀 -->
<div id="HEAD-TAB" class="tab1_style js-admin-payment-tab mgt30">
	<a class="on" data="PAYMENT-CONT"><span>결제 카드 변경</span></a>
	<a data="PAYMENT-FAQ" class="off"><span>자주 묻는 질문</span></a>
</div>


<div id="PAYMENT-CONT-WRAP" class="js-payment-cont-wrap" style="display: block;">
	<!-- 설명 -->
	<div class="titleh2_style mgt10">
		<h2 data-langcode="ADMINBILLING005">플로우 결제 수단으로 등록된 카드 정보를 변경할 수 있습니다. <br>카드 외의 결제 수단(CMS/계좌이체/바우처)을 사용하시는 경우에는 ‘고객 센터’를 통해 문의해 주세요.</h2><!-- btn both -->
		<div class="right"><a id="change_card_btn" class="btn plusbtn_style"><span data-langcode="ADMINBILLING006" style="padding-left:0px; background:none;">결제 수단 변경</span> </a></div>
	</div>
	<!-- //설명 -->
	<div class="list_table mgt15">
		<table cellpadding="0" cellspacing="0">
				<caption></caption>
				<colgroup>
					<col style=";">
					<col style=";">
					<col style=";">
					<col style=";">
				</colgroup>
			<thead>
				<tr>
					<th scope="col"><div data-langcode="ADMINBILLING001">카드 구분</div></th>
					<th scope="col"><div data-langcode="ADMINBILLING002">카드 번호(끝 4자리)</div></th>
					<th scope="col"><div data-langcode="ADMINBILLING003">유효기간</div></th>
					<th scope="col"><div data-langcode="ADMINBILLING004">결제구분</div></th>
				</tr>
			</thead>
		</table>
		<div class="scrollbox">
			<table id="card_list" cellpadding="0" cellspacing="0">
				<caption></caption>
				<colgroup>
					<col style=";">
					<col style=";">
					<col style=";">
					<col style=";">
				</colgroup>
				<tbody><tr><td colspan="4"><b>[결제된 내역이 없습니다]</b></td></tr></tbody>
			</table>
		</div>
	</div>
	<div id="pay_info_layer" style="display: none;">
		<div class="titleh2_style mgt10">
			<h2>현재까지 결제 내역 (매월 10일날 후불 결제 됩니다)</h2><!-- btn both -->
		</div>

		<div class="list_table mgt15">
			<table cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
						<col style="">
						<col style="">
						<col style="">
						<col style="">
					</colgroup>
				<thead>
					<tr>
						<th scope="col"><div>결제일</div></th>
						<th scope="col"><div>결제인원</div></th>
						<th scope="col"><div>결제금액</div></th>
						<th scope="col"><div>특이사항</div></th>
					</tr>
				</thead>
			</table>
			<div class="scrollbox">
				<table id="pay_info" cellpadding="0" cellspacing="0">
					<caption></caption>
					<colgroup>
						<col style="">
						<col style="">
						<col style="">
						<col style="">
					</colgroup>
					<tbody><tr><td colspan="5"><b>[결제된 내역이 없습니다]</b></td></tr></tbody>
				</table>
			</div>
		</div>
	</div>


	<!--  결제진행중 -->
	<div class="diminly-pop" style=" display: none;">
		<div class="alertlyr-pop">
			<p class="line2">진행 중입니다.<br>잠시만 기다려 주세요!</p>
			<div class="loader_bx"><div class="loader" title="Loading..."></div></div>
		</div>
	</div><!-- //결제진행중 -->

	<div id="flow-pay-input" class="bgmodal_wrap" style="display: none;">

	
		<div class="lyaer_popup_wrap" style="width:410px;top:50%;left:50%;transform:translate(-50%,-50%);">
			<div class="lyaer_popup_top">
				<h1>결제 정보</h1>
				<input type="button" class="pop_close" title="닫기" style="cursor:pointer;">
			</div>

			<div class="pay_wrap">
				<ul>
					<li>· 이용 요금은 등록한 카드정보로 매월 자동 결제됩니다.</li>
					<li>· 카드 확인을 위해 1,000원 결제 후 자동 취소됩니다.</li>
				</ul>
				<!-- 정보입력폼 -->
				<form id="payForm" action="">
					<fieldset>
						<legend>결제 정보</legend>
						<div class="payment_cont topline_none">
							<dl>
								<dt>이름</dt>
								<dd>
									<input type="text" id="flow-user-name" maxlength="50" placeholder="이름" value="">
									<div class="name-error-msg" style="display: none;">
										<div class="error-cont">이름을 입력하세요 </div>
									</div><!-- //오류메시지 -->
								</dd>
								<dt>이메일</dt>
								<dd>
									<input type="text" id="flow-user-email" maxlength="100" placeholder="example@flow.team" value="" style="color: #bcbdbd; background-color: #f9f9fa;" disabled="">
									<div class="email-error-msg" style="display: none;">
										<div class="error-cont">이메일 형식이 아닙니다</div>
									</div><!-- //오류메시지 -->
								</dd>
								<dt>휴대폰 번호</dt>
								
								<dd>
									<input type="text" id="flow-user-number" maxlength="20" placeholder="숫자와 +,-만 입력 가능합니다" value="">
									<div class="number-error-msg" style="display: none;">
										<div class="error-cont">전화번호 형식이 맞지 않습니다.</div>
									</div><!-- //오류메시지 -->
								</dd>
								
							</dl>

							<div class="area_both2">
								<dl style="width: 100%;">
									<dt>카드번호</dt>
									<dd>
										<dl style="width: 20%;">
											<dd>
												<input type="text" id="cn1" class="cn" maxlength="4" placeholder="****" value="" style="width:20%;">
													<div class="cn1-error-msg" style="display: none;">
														<div class="error-cont">다시 한번 확인해주세요</div>
													</div><!-- //오류메시지 -->
											</dd>
										</dl>
										<dl style="width: 5%;">
											<dd>&nbsp;-&nbsp;</dd>
										</dl>
										<dl style="width: 20%;">
											<dd>
												<input type="text" id="cn2" class="cn" maxlength="4" placeholder="****" value="" style="width:20%;">
													<div class="cn2-error-msg" style="display: none;">
														<div class="error-cont">다시 한번 확인해주세요</div>
													</div><!-- //오류메시지 -->
											</dd>
										</dl>
										<dl style="width: 5%;">
											<dd>&nbsp;-&nbsp;</dd>
										</dl>
										<dl style="width: 20%;">
											<dd>
												<input type="password" id="cn3" class="cn" maxlength="4" placeholder="****" value="" style="width:20%;">
													<div class="cn3-error-msg" style="display: none;">
														<div class="error-cont">다시 한번 확인해주세요</div>
													</div><!-- //오류메시지 -->
											</dd>
										</dl>
										<dl style="width: 5%;">
											<dd>&nbsp;-&nbsp;</dd>
										</dl>
										<dl style="width: 20%;">
											<dd>
												<input type="password" id="cn4" maxlength="4" placeholder="****" value="" style="width:20%;">
													<div class="cn4-error-msg" style="display: none;">
														<div class="error-cont">다시 한번 확인해주세요</div>
													</div><!-- //오류메시지 -->
											</dd>
										</dl>
									</dd>
								</dl>
							</div>
							<div class="area_both2">
								<dl style="width: 60%;">
									<dt>유효기간</dt>
									<dd>
										<!-- 월 -->
										<select name="month" id="expiryMonth" style="width: 70px;">
											<option selected="selected">01월</option>
											<option>02월</option>
											<option>03월</option>
											<option>04월</option>
											<option>05월</option>
											<option>06월</option>
											<option>07월</option>
											<option>08월</option>
											<option>09월</option>
											<option>10월</option>
											<option>11월</option>
											<option>12월</option>
										</select>&nbsp;
										<!-- 년 -->
										<select name="year" id="expiryYear" style="width: 90px;">
											<option selected="selected">2019년</option>
											<option>2020년</option>
											<option>2021년</option>
											<option>2022년</option>
											<option>2023년</option>
											<option>2024년</option>
											<option>2025년</option>
											<option>2026년</option>
											<option>2027년</option>
											<option>2028년</option>
											<option>2029년</option>
										</select>
									</dd>
								</dl>
								<dl style="width: 40%;" class="card_password">
									<dt>비밀번호 앞 두자리</dt>
									<dd>
										<input type="password" class="fcdpwd" maxlength="2" placeholder="**" value="" style="min-width: auto; width: 50px; letter-spacing: 6px; text-indent: 4px;">
										<span class="afterpw">**</span>
										<div class="pwd-error-msg" style="display: none;">
											<div class="error-cont">다시 한번 확인해주세요</div>
										</div><!-- //오류메시지 -->
									</dd>
								</dl>
							</div>
							<dl>
								<dt>사업자번호 10자리(법인) / 생년월일 6자리(개인)</dt>
								<dd>
									<input type="text" class="inNum" maxlength="10" placeholder="- 빼고 입력" value="">
									<!-- 오류메시지 -->
									<div class="birth-error-msg" style="display: none;">
										<div class="error-cont">사업자 번호를 확인해주세요</div>
									</div><!-- //오류메시지 -->
								</dd>
							</dl>
						</div>
						<div class="agrebx"><input class="check" type="checkbox"><label style="font-size:11px">&nbsp;<a id="paymentTermsLink" style="color:#4c80d6;" data-langcode="FIP1526"><b>정기과금 이용 약관</b> </a><span data-langcode="FIP1527"> 내용을 확인하였고, 이에 동의합니다.</span></label></div>
						<div class="agrebx"><label class="errormsg"></label></div>
						<div class="btn-box">
							<button type="button" id="executePayment" class="btn-bigs" product-name="business" disabled="">카드 정보 등록</button><!-- [D] 비활성 disable -->
						</div>
					</fieldset>
				</form><!-- //정보입력폼 -->
				<p class="ico-clean">결제 정보는 SSL 암호화로 안전하게 전송되며, 카드정보를 서버에 저장하지 않습니다.</p>

				<!--  카드확인중 -->
				<div id="paymentPendingLayerPopup" class="dim-wrap" style="display: none;">
					<div class="dim-row">
						<div class="dim-cell">
							<div class="dim-bg"></div>
							<div class="diminly-pop">
								<div class="alertlyr-pop">
									<p class="line2">잠시만 기다려주세요.</p>
									<div class="loader_bx">
										<div class="loader" title="Loading..."></div>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<!-- //결제진행중 -->
			</div>
		</div>

		<div id="billingTerms" class="bgmodal_wrap" style="display:none;z-index:14000;">
		<div class="geust_login_pop center-popup" style="width:610px;height:770px; margin-top: -400px; margin-left: -255px;">
			<div class="geust_login_wrap">

				<h1 class="font-Noto" style="margin-top:-20px;font-size:25px;color:#111;" data-langcode="CLP1116">과금 정책</h1>

				<div class="termspop_scroll mCustomScrollbar _mCS_3 mCS_no_scrollbar"><div id="mCSB_3" class="mCustomScrollBox mCS-light mCSB_vertical mCSB_inside" style="max-height: 443px;" tabindex="0"><div id="mCSB_3_container" class="mCSB_container mCS_y_hidden mCS_no_scrollbar_y" style="position:relative; top:0; left:0;" dir="ltr">
					<dl>
						<dt data-langcode="">과금 정책</dt>

	
	
	
	
	
	
	
	
	
	
	
	
						<dd data-langcode="">
							・ 선택한 요금제에 따라서 월간 혹은 연간 과금 형태로 결제가 진행됩니다.
						</dd>
						<dd data-langcode="">
							・ 정확한 결제 정보를 입력하셔야 하며, 결제 정보를 제공할 경우 플로우(또는 플로우가 지정한 결제 대행업체)가 해당 거래에 필요한 결제 금액 전체를 청구할 수 있도록 허가한
							것으로 간주합니다. 부가세는 별도로 부과됩니다.
						</dd>
						<dd data-langcode="">
							・ 별도의 취소 의사가 없는 한, 선택한 요금제에 과금이 진행됩니다. 취소 시, 결제 중단 처리가 되며 청구할 금액이 남아 있다면 다음 달에 과금이 청구됩니다.
						</dd>
						<dd data-langcode="">
							・ 이미 지불이 완료된 금액에 대해서는 환불이 불가합니다. 단, 플로우의 귀책사유로 인해 잘못된 금액이 결제되었거나 초과 과금이 발생한 경우 환불이 가능합니다.
						</dd>
					</dl>

					<dl>
						<dt data-langcode="">월간 과금</dt>
	
	
	
	
	
	
	
	
	
						<dd data-langcode="">
							・ 매달 정기적으로 전월 사용금액에 대해서 결제가 진행됩니다. 기본요금 이외에 등록된 매월 최대 사용 인원을 기준으로 추가요금이 산정됩니다. 월간 과금에서 연간 과금으로 전환을
							지원하지 않습니다.
						</dd>
					</dl>

					<dl>
						<dt data-langcode="">연간 과금</dt>
	
	
	
	
	
	
	
	
	
						<dd data-langcode="">
							・ 연간 사용금액에 대해서 선결제가 진행됩니다. 기본요금 이외에 등록된 사용 인원을 기준으로 추가요금이 산정됩니다.
						</dd>
						<dd data-langcode="">
							・ 연간 과금에서 월간 과금으로 전환을 지원하지 않으며, 사용 인원이 감소한 경우 해당 요금에 대해서 환불 처리되지 않습니다.
						</dd>
						<dd data-langcode="">
							・ 연간 과금 결제 이후 사용 인원이 결제 기준 인원에서 추가될 경우 인원 당 추가 요금을 청구합니다. 추가된 사용 인원에 대한 결제 금액은 사용 인원이 감소하더라도 해당 요금에 대해 환불 처리되지 않습니다.
						</dd>
						<dd data-langcode="">
							・ 추가 인원 계산 공식은 아래와 같습니다. <br>
							(1) 추가된 사용 인원 X 연간 요금제 월 요금 X 남은 기간
						</dd>
						<dd data-langcode="">
							・ 추가된 사용 인원에 대한 결제 금액은 사용 인원이 감소하더라도 해당 요금에 대해 환불 처리되지 않습니다.
						</dd>
						<dd data-langcode="">
							・ 연간 과금으로 결제 시, 계약 기간 중 서비스 탈퇴 시 위약금이 발생합니다. 위약금은 "월간과금 대비 할인받은 금액 + 남은 기간 동안 지불할 금액의 10%"이며, 위약금에는 Tax가 부과되지 않습니다.
						</dd>
						<dd data-langcode="">
							・ 월간 과금 대비 할인 받은 금액은 연간 과금 계약 시 체결한 월 청구금액 기준으로 계산되며, 남은 기간 동안 지불할 금액의 10%는 서비스 탈퇴 신청일부터 이전 30일 동안 최대 사용 인원 기준으로 계산됩니다. <br>
							위약금 계산 공식은 아래와 같습니다. <br>
							(1) 월간 과금 요금제 대비 할인 받은 금액 = {사용기간 월 X (월간과금제월요금 - 연간과금제월요금)}<br>
							(2) 남은 기간 동안 지불할 금액의 10% = {연간과금제 월계약금액 X (총계약기간 월-사용기간 월)+(추가 사용 인원 사용금액)} X 10%<br>
							(3) 위약금 = (1) + (2)
						</dd>
					</dl>

					<dl>
						<dt data-langcode="">결제 실패</dt>
	
	
	
						<dd data-langcode="">
							・ 결제 시점에 결제가 실패하면 이후 2회까지 재결제를 시도하고 이후에도 결제에 실패하면 서비스 이용을 중지합니다.
						</dd>
						<dd data-langcode="">
							・ "고객"은 미납액이 발생하는 경우 납부의 의무가 있으며 미납이 30일 이상 지속될 경우 서비스에 제한이 있을 수 있습니다. 미납액에 대한 포기 및 취소는 가능하지 않으며,
							이용료 지불에 대한 납세의 책임 또한 "고객"에게 있습니다.
						</dd>
					</dl>

					<dl>
						<dt data-langcode="">기타</dt>
	
	
	
						<dd data-langcode="">
							・ 플로우가 지정한 결제 대행업체는 결제 처리를 위해 제공해 주신 결제 정보를 수집 및 저장할 수 있으며, 결제 정보는 결제 외 다른 용도로 사용되지 않습니다. 취소 관련 문의는
							<a href="mailto:support@flow.team">support@flow.team </a>또는 1:1
							문의하기를 통해 가능합니다.
						</dd>
					</dl>


					<dl>
						<dd data-langcode="">
							・ 본 약관에 명시되지 않은 내용은 플로우 <a class="payment-popup-link" href="/terms.act" target="serviceTerms">서비스
							이용약관</a> 및 <a class="payment-popup-link" href="/privacy.act" target="flowPrivacy">개인정보 처리방침</a>을 따릅니다.
						</dd>
	
	
	
					</dl>
					<dl>
	
	
	
						<dd data-langcode="">
							・ 시행일 : 2022년 05월 25일
						</dd>
					</dl>

				</div><div id="mCSB_3_scrollbar_vertical" class="mCSB_scrollTools mCSB_3_scrollbar mCS-light mCSB_scrollTools_vertical" style="display: none;"><div class="mCSB_draggerContainer"><div id="mCSB_3_dragger_vertical" class="mCSB_dragger" style="position: absolute; min-height: 30px; top: 0px;" oncontextmenu="return false;"><div class="mCSB_dragger_bar" style="line-height: 30px;"></div></div><div class="mCSB_draggerRail"></div></div></div></div></div>
				<button class="btnStyle_ht50" data-langcode="CLP1129">위 내용에 동의합니다.</button>

				<button class="closebtn"><span class="blind" data-langcode="CLP948">닫기</span></button>
			</div>
		</div>
	</div>

	</div>

</div>
<div id="planChangeModal" class="plan-change-modal" style="display: none">
	<div class="plan-change-modal-section">
		<div class="plan-change-modal-title">
			<div>상품 변경 문의</div>
			<input type="button" class="pop_close" title="닫기" style="cursor:pointer;">
		</div>
		<div class="plan-change-modal-desc">
			아래의 항목을 남겨주시면, 유선상담 후 상품을 변경할 수 있습니다.
		</div>
		<div class="plan-change-modal-content">
			<div>
				<label for="planChangeCurrentPlan">현 사용 상품</label>
				<input type="text" id="planChangeCurrentPlan" disabled="" required="">
			</div>
			<div>
				<label for="planChangeWantPlan">변경 희망 상품</label>

				<input type="text" class="my-type-2 js-select-dayoff" value="비즈니스 베이직" disabled="">
				<input type="hidden" id="planChangeWantPlan" value="비즈니스 베이직 (BUSINESS_BASIC_KR_E)" required="">

				
				
			</div>
			<div>
				<label for="planChangeInttNm">회사 이름</label>
				<input type="text" id="planChangeInttNm" disabled="" required="">
			</div>
			<div>
				<label for="planChangeUserNm">요청자명 <span class="c_red">(필수)</span></label>
				<input type="text" id="planChangeUserNm" required="">
			</div>
			<div>
				<label for="planChangeEmail">이메일 <span class="c_red">(필수)</span></label>
				<input type="text" id="planChangeEmail" required="">
			</div>
			
			<div>
				<label for="planChangeComTel">회사연락처</label>
				<input type="text" id="planChangeComTel" placeholder="숫자와 +,-만 입력 가능합니다" maxlength="20">
			</div>
			
			
			<div>
				<label for="planChangePhoneNum">휴대폰 번호 <span class="c_red">(필수)</span></label>
				<input type="text" id="planChangePhoneNum" placeholder="숫자와 +,-만 입력 가능합니다" maxlength="20" required="">
			</div>
			
			<div>
				<label for="planChangeContent">문의사항 <span class="c_red">(필수)</span></label>
				<textarea id="planChangeContent" rows="5" placeholder="요청사항을 입력해 주세요." style="padding: 6px 10px" required=""></textarea>
			</div>
		</div>
		<div class="plan-change-modal-bottom">
			<button id="planChangeModalCancel" class="plusbtn_style">취소</button>
			<button id="planChangeModalSubmit" class="plusbtn_style btn_flow">확인</button>
		</div>
	</div>
	<div class="plan-change-modal-bg"></div>
</div>

<div id="PAYMENT-FAQ-WRAP" class="js-payment-faq-wrap payment-faq-wrap" style="display: none;">
	<div class="list_table mgt15">
		<table cellpadding="0" cellspacing="0">
			<caption></caption>
			<colgroup>
				<col style="width: 200px;">
				<col style="*">
			</colgroup>
			<thead>
			<tr>
				<th scope="col"><div>구분</div></th>
				<th scope="col"><div>질문내용</div></th>
			</tr>
			</thead>
		</table>
		<div class="scrollbox">
			<table id="card_list" cellpadding="0" cellspacing="0" pay_gubun="Y">
				<caption></caption>
				<colgroup>
					<col style="width: 200px;">
					<col style="*">
				</colgroup>
				<tbody>
					<tr>
						<td>요금제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/234707747">게스트(무료회원)와 비즈니스 계정은 어떻게 다른가요?</a></td>
					</tr>
					<tr>
						<td>요금제</td>
						<td><a target="_blank" href="https://flow.team/kr/price">플로우 요금제(사용금액)는 어떻게 되나요?</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/360001697952">결제를 하고 싶습니다. 정기결제 방식을 알고싶어요!</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/360052953011">카드 등록 시 1,000원이 결제되었습니다.</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/17065052099353">결제 카드 변경 방법이 궁금해요.</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/17167694305817">결제 방법을 변경하고 싶습니다.</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/360042850032">카드 결제 영수증(매출전표)을 확인하고 싶어요!</a></td>
					</tr>
					<tr>
						<td>결제</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/4409340351769">청구 실패 안내를 받았습니다.</a></td>
					</tr>
					<tr>
						<td>기타</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/sections/360010012432">비대면 서비스 바우처로 서비스 이용이 가능한가요?</a></td>
					</tr>
					<tr>
						<td>기타</td>
						<td><a target="_blank" href="https://support.flow.team/hc/ko/articles/10003837009561">업무 포털 결제 방식을 알고 싶어요.</a></td>
					</tr>
				</tbody>
			</table>
		</div>
	</div>
</div>
<div class="pay-info-option-div">
	<button id="planChange" class="plusbtn_style btn_flow" style="display: block;">상품 변경</button>
	<button id="serviceCancellation" class="plusbtn_style">해지 접수</button>
</div>
                </span>
                
                
                
                <div class="alert_box" style="display: none;">
					<pre>관리자 인원은 최소 한 명 이상 필요합니다.</pre>
				</div>
                
                
                
                
                
                
					
				</div>
			</div>
		</div>
	</div>
</body>
</html>