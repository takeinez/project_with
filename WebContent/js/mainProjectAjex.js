function load_my_mention(nowId,boardCase){
	$.ajax({
		url : 'mention',
		method : 'POST',
		
		data: {
			send_id : nowId,
			send_boardCase : boardCase
		},
		success : function(responseData){
			var dataList = responseData;
			let boardCount = 0;
			for(let i=0;i<dataList.length;i++){
				boardCount +=1;
				let project_id = dataList[i].project_id;
				let project_name = dataList[i].project_name;
				let board_id = dataList[i].board_id;
				let board_type = dataList[i].board_type;
				let board_title = dataList[i].board_title;
				let board_writer = dataList[i].board_writer;
				let regist_date = dataList[i].regist_date;
				let reply_writer = dataList[i].reply_writer;
				let reply_content = dataList[i].reply_writer;
				let reply_date = dataList[i].reply_date;
				let reply_count = dataList[i].reply_count;
				
				let boardSub = "";
				let boardIco = "";
				if(board_type==1){ //글 유형마다 다른 아이콘 및 문구 나와야함.
					boardSub = "글";
					boardIco = "fa-regular fa-file-lines";
					
				}else if(board_type ==2){
					boardSub = "업무";
					boardIco = "fa-solid fa-list-check";
				}else if(board_type ==3){
					boardSub = "일정";
					boardIco = "fa-regular fa-calendar";
				}else if(board_type==4){
					boardSub = "할일";
					boardIco = "fa-regular fa-square-check";
				}else if(board_type==-1){
					boardSub = "댓글";
					boardIco = "fa-regular fa-message";
				}else{
					boardSub = "투표";
					boardIco = "fa-solid fa-check-to-slot";
				}
				let comentCount = "";
				if(reply_content==null){
					reply_content="";
					reply_date="";
					reply_writer="";
				}else{
					comentCount = ' style="display:none;"';
					board_title="";
					regist_date="";
					boardSub = "댓글";
					boardIco = "fa-regular fa-message";
					board_writer="";
				}
				$("#myPostContentUl").append(
					'<li id="'+ board_id +'" class="post-search-item post-list-wrapper" post-type="'+board_type+'">' 
					+ '	<div class="fixed-kind">' 
					+ '		<i class="icons-write2">' 
					+ '			<i class="'+boardIco+'"></i>' 
					+ '		</i>' 
					+ '		<span class="post-type">'+boardSub+'</span>' 
					+ '	</div>' 
					+ '	<div class="search-sub-text-wrap">' 
					+ '		<div class="contents-cmt">' 
					+ '			<p class="search-text-type-3 contents-tit">'+board_title+reply_content+'</p>' 
					+ '			<div class="post-list comment" '+comentCount+'">' 
					+ '				<i class="icons-comment2">' 
					+ '					<i class="fa-regular fa-message"></i>' 
					+ '				</i>' 
					+ '				<span>'+reply_count+'</span>' 
					+ '			</div>' 
					+ '		</div>' 
					+ '		<p class="search-text-type-3 contents-project">' 
					+ '			<em class="ellipsis">' 
					+ '				<i class="seach-type-2"></i>' 
									+ project_name  
					+ '			</em>' 
					+ '		</p>' 
					+ '	</div>' 
					+ '	<div class="post-list-right">' 
					+ '		<div class="post-list name">'+board_writer+reply_writer+'</div>' 
					+ '		<div class="post-list date">'+regist_date+reply_date+'</div>' 
					+ '	</div>' 
					+ '</li>' 
				);
			}
			$("#postCount").html(boardCount);
		}
	});
}

function load_my_board(nowId,boardCase){ //내 게시물
	$.ajax({
		
	    url: 'mypost',
	    method: 'POST',
	    
		data: {
			send_id : nowId,
			send_boardCase :boardCase
		},
	    success: function(responseData) {
		
	        var dataList = responseData;
	        // ArrayList 값을 사용하는 코드
//	        console.log(dataList); // ["Item 1", "Item 2", "Item 3"]
	        // ...
//			console.log(dataList.length);
			let boardCount = 0;
			for(let i = 0;i<dataList.length;i++){
				boardCount+=1;
				let project_id = dataList[i].project_id;
				let project_name = dataList[i].project_name;
				let board_id = dataList[i].board_id;
				let board_type = dataList[i].board_type;
				let board_title = dataList[i].board_title;
				let board_writer = dataList[i].board_writer;
				let regist_date = dataList[i].regist_date;
				let reply_count = dataList[i].reply_count;
				let boardSub = "";
				let boardIco = "";
				if(board_type==1){ //글 유형마다 다른 아이콘 및 문구 나와야함.
					boardSub = "글";
					boardIco = "fa-regular fa-file-lines";
					
				}else if(board_type ==2){
					boardSub = "업무";
					boardIco = "fa-solid fa-list-check";
				}else if(board_type ==3){
					boardSub = "일정";
					boardIco = "fa-regular fa-calendar";
				}else if(board_type==4){
					boardSub = "할일";
					boardIco = "fa-regular fa-square-check";
				}else{
					boardSub = "투표";
					boardIco = "fa-solid fa-check-to-slot";
				}
				$("#myPostContentUl").append(
					'<li id="'+ board_id +'" class="post-search-item post-list-wrapper" post-type="'+board_type+'">' 
					+ '	<div class="fixed-kind">' 
					+ '		<i class="icons-write2">' 
					+ '			<i class="'+boardIco+'"></i>' 
					+ '		</i>' 
					+ '		<span class="post-type">'+boardSub+'</span>' 
					+ '	</div>' 
					+ '	<div class="search-sub-text-wrap">' 
					+ '		<div class="contents-cmt">' 
					+ '			<p class="search-text-type-3 contents-tit">'+board_title+'</p>' 
					+ '			<div class="post-list comment" style="display:block;">' 
					+ '				<i class="icons-comment2">' 
					+ '					<i class="fa-regular fa-message"></i>' 
					+ '				</i>' 
					+ '				<span>'+reply_count+'</span>' 
					+ '			</div>' 
					+ '		</div>' 
					+ '		<p class="search-text-type-3 contents-project">' 
					+ '			<em class="ellipsis">' 
					+ '				<i class="seach-type-2"></i>' 
									+ project_name  
					+ '			</em>' 
					+ '		</p>' 
					+ '	</div>' 
					+ '	<div class="post-list-right">' 
					+ '		<div class="post-list name">'+board_writer+'</div>' 
					+ '		<div class="post-list date">'+regist_date+'</div>' 
					+ '	</div>' 
					+ '</li>' 
				);
			}
			$("#postCount").html(boardCount);
	    }
	});
}
function load_my_bookmark(nowId,boardCase){ //내 북마크
	$.ajax({
		
	    url: 'book',
	    method: 'POST',
	    
		data: {
			send_id : nowId,
			send_boardCase :boardCase
		},
	    success: function(responseData) {
		var dataList = responseData;
		
		let boardCount = 0;
			for(let i = 0;i<dataList.length;i++){
				boardCount+=1;
				let project_id = dataList[i].project_id;
				let project_name = dataList[i].project_name;
				let board_id = dataList[i].board_id;
				let board_type = dataList[i].board_type;
				let board_title = dataList[i].board_title;
				let board_writer = dataList[i].board_writer;
				let regist_date = dataList[i].regist_date;
				let reply_count = dataList[i].reply_count;
				let boardSub = "";
				let boardIco = "";
				if(board_type==1){ //글 유형마다 다른 아이콘 및 문구 나와야함.
					boardSub = "글";
					boardIco = "fa-regular fa-file-lines";
					
				}else if(board_type ==2){
					boardSub = "업무";
					boardIco = "fa-solid fa-list-check";
				}else if(board_type ==3){
					boardSub = "일정";
					boardIco = "fa-regular fa-calendar";
				}else if(board_type==4){
					boardSub = "할일";
					boardIco = "fa-regular fa-square-check";
				}else{
					boardSub = "투표";
					boardIco = "fa-solid fa-check-to-slot";
				}
				$("#myPostContentUl").append(
					'<li id="'+ board_id +'" class="post-search-item post-list-wrapper" post-type="'+board_type+'">' 
					+ '	<div class="fixed-kind">' 
					+ '		<i class="icons-write2">' 
					+ '			<i class="'+boardIco+'"></i>' 
					+ '		</i>' 
					+ '		<span class="post-type">'+boardSub+'</span>' 
					+ '	</div>' 
					+ '	<div class="search-sub-text-wrap">' 
					+ '		<div class="contents-cmt">' 
					+ '			<p class="search-text-type-3 contents-tit">'+board_title+'</p>' 
					+ '			<div class="post-list comment" style="display:block;">' 
					+ '				<i class="icons-comment2">' 
					+ '					<i class="fa-regular fa-message"></i>' 
					+ '				</i>' 
					+ '				<span>'+reply_count+'</span>' 
					+ '			</div>' 
					+ '		</div>' 
					+ '		<p class="search-text-type-3 contents-project">' 
					+ '			<em class="ellipsis">' 
					+ '				<i class="seach-type-2"></i>' 
									+ project_name  
					+ '			</em>' 
					+ '		</p>' 
					+ '	</div>' 
					+ '	<div class="post-list-right">' 
					+ '		<div class="post-list name">'+board_writer+'</div>' 
					+ '		<div class="post-list date">'+regist_date+'</div>' 
					+ '	</div>' 
					+ '</li>' 
				);
			}
			$("#postCount").html(boardCount);
		}
	});
}
function load_my_tempsave(nowId,boardCase){ //임시저장
	$.ajax({
		
	    url: 'tempsave',
	    method: 'POST',
	    
		data: {
			send_id : nowId,
			send_boardCase :boardCase
		},
	    success: function(responseData) {
			var dataList = responseData;
			let boardCount = 0;
			for(let i=0;i<dataList.length;i++){
				boardCount+=1;
				let project_name = dataList[i].project_name;
				let board_id = dataList[i].board_id;
				let board_type = dataList[i].board_type;
				let board_title = dataList[i].board_title;
				let board_writer = dataList[i].board_writer;
				let regist_date = dataList[i].regist_date;
				let boardSub = "";
				let boardIco = "";
				if(board_type==1){ //글 유형마다 다른 아이콘 및 문구 나와야함.
					boardSub = "글";
					boardIco = "fa-regular fa-file-lines";
					
				}else if(board_type ==2){
					boardSub = "업무";
					boardIco = "fa-solid fa-list-check";
				}else if(board_type ==3){
					boardSub = "일정";
					boardIco = "fa-regular fa-calendar";
				}else if(board_type==4){
					boardSub = "할일";
					boardIco = "fa-regular fa-square-check";
				}else{
					boardSub = "투표";
					boardIco = "fa-solid fa-check-to-slot";
				}
				$("#myPostContentUl").append(
					'<li id="'+ board_id +'" class="post-search-item post-list-wrapper" post-type="'+board_type+'">' 
					+ '	<div class="fixed-kind">' 
					+ '		<i class="icons-write2">' 
					+ '			<i class="'+boardIco+'"></i>' 
					+ '		</i>' 
					+ '		<span class="post-type">'+boardSub+'</span>' 
					+ '	</div>' 
					+ '	<div class="search-sub-text-wrap">' 
					+ '		<div class="contents-cmt">' 
					+ '			<p class="search-text-type-3 contents-tit">'+board_title+'</p>' 
					+ '			<div class="post-list comment" style="display:none;">' 
					+ '				<i class="icons-comment2">' 
					+ '					<i class="fa-regular fa-message"></i>' 
					+ '				</i>' 
					+ '				<span></span>' 
					+ '			</div>' 
					+ '		</div>' 
					+ '		<p class="search-text-type-3 contents-project">' 
					+ '			<em class="ellipsis">' 
					+ '				<i class="seach-type-2"></i>' 
									+ project_name  
					+ '			</em>' 
					+ '		</p>' 
					+ '	</div>' 
					+ '	<div class="post-list-right">' 
					+ '		<div class="post-list name">'+board_writer+'</div>' 
					+ '		<div class="post-list date">'+regist_date+'</div>' 
					+ '	</div>' 
					+ '</li>' 
				);
			}
			$("#postCount").html(boardCount);
		}
	});
}
function thisIsMyFavorite(nowId,pro_id,now_favorite){ //즐겨찾기 별 누를때
	$.ajax({
		url: "환승하자DB.jsp",
		type: "POST",
		data: {
			send_num: 0,
			send_employee_id: nowId,
			send_projectId: pro_id,
			send_now_favorite: now_favorite
			
		},
		
		success: function(tmf){
				
		}
	});
}

function load_myProject(nowId,order,filter) {//내 프로젝트 페이지 로드
	$.ajax({
		url: "환승하자DB.jsp",
		type: "POST",
		data: {
			send_num:1,
			send_employee_id: nowId,
			send_order: order,
			send_filter: filter
		},
		
		success: function(abc) {
//			console.log(abc);
//			$("#projectBoardUI").load("${contextPath} #projectBoardUI");
			$("#projectBoardUl").html(
				 '		<div class="section-1 middle-line"> '
				+ '			<p class="project-class join">즐겨찾기</p> '
				+ '		</div> '
				+ '		<div class="section-2 middle-line"> '
				+ '			<p class="project-class join">참여중</p> '
				+ '		</div> '
			);
			$("#projectListUl").html(
				 '		<div class="section-1 middle-line"> '
				+ '			<p class="project-class join">즐겨찾기</p> '
				+ '		</div> '
				+ '		<div class="section-2 middle-line"> '
				+ '			<p class="project-class join">참여중</p> '
				+ '		</div> '
			);
			abc = JSON.parse(abc);
			
			let favoriteCount =0;
			for(let i = 0;i<abc.length;i++){
				let project_name = abc[i].project_name;
				let projectMemberCount = abc[i].projectMemberCount;
				let project_id = abc[i].project_id;
				let projectColor = abc[i].projectColor;
				let favorite = abc[i].favorite;
				let favoriteS =null;
				let favoriteL =null;
				//프로젝트에 표시되는 아이콘에 대하여
				let projectCase =abc[i].project_case;
				let join_permission = abc[i].join_permission;
				let proIco_open = "style='display:none'";
				let proIco_jms = "style='display:none'";
				let proIco_notice = "style='display:none'";
				let proIco_company = "style='display:none'";
				let notification = abc[i].push_switch;
				if(notification!=1){
					proIco_notice = "style='display:inline-block'";
				}
				if(projectCase==2){
					proIco_open = "style='display:inline-block;'";
				}
				else if(projectCase==3){
					proIco_company = "style='display:inline-block;'";
				}
				if(join_permission==1){
					proIco_jms = "style='display:inline-block;'";
				}
				let whereIsMySeat = null;//내 프로젝트에서 어느칸으로 갈지 선택함.
				if(favorite==1){
					favoriteS="with-content-star";
					favoriteL="with-content-star-2"
					favoriteCount+=1;
					$("#projectBoardUl").children(".section-2").before(
					"<li id='"+project_id+"' class='project-item ui-state-default'> " 
					+ "	<a class='cursor-pointer'> "
					+ "		<div class='with-content-ct project-badge' style='display: none;'>0</div> "
					+ "		<button class='edit-check with-content-chk' style='display:none;'></button> "
					+ "		<div class='color-code left-menu-type-1 color-"+projectColor+"' data-color='"+projectColor+"'></div> "
  					+ "		<div class='left-menu-type-con'> "
					+ "			<div class='project-star "+favoriteS+"'></div> "
					+ "			<div class='with-content-txt project-ttl'>"+ project_name +"</div> "
					+ "			<div class='with-content-b-c' style='display:block;'> "
					+ "				<div class='with-content-hm-txt'> "
					+ "					<i class='fa-regular fa-user'></i> "
					+ "				</div> "
					+ "				<span class='member-cnt'>"+ projectMemberCount +"</span> "
					+ "				<div class='with-content-fl-r'> "
					+ "                   <div class='project-stat-ico with-content-jms-ico' "+proIco_jms+" data=''></div> "
					+ "                   <div class='project-stat-ico with-content-bl-ico' "+proIco_notice+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-open-project' "+proIco_open+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-company' "+proIco_company+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-unknown' style='display:none' data=''></div> "
					+ "             </div> "
					+ "			</div> "
					+ "		</div> "
					+ "	</a> "
					+ "</li> "
					);
					$("#projectListUl").children(".section-2").before(
					'<li id="'+project_id+'" class="project-item">'
					+ '	<a class="cursor-pointer">'
					+ '		<button class="edit-check with-content-chk d-none"></button>'
					+ '		<div class="color-code with-content-list with-content-po-t color-'+projectColor+'"></div>'
					+ '		<div class="project-star with-content-po-t '+favoriteL+'"></div>'
					+ '		<span class="project-ttl">'+ project_name +'</span>'
					+ '		<div class="with-content-hm-txt">'
					+ '			<i class="fa-regular fa-user"></i>'
					+ '		</div>'
					+ '		<span class="member-cnt" style="display:inline-block;">'+ projectMemberCount +'</span>'
					+ '		<strong class="project-badge" style="display:none;">39</strong>'
					+ '		<div class="with-content-fl-r"> '
				    + '              <div class="project-stat-ico with-content-jms-ico" '+proIco_jms+' data=""></div> '
				    + '              <div class="project-stat-ico with-content-bl-ico" '+proIco_notice+'  data=""></div> '
				    + '              <div class="project-stat-ico icon-open-project" '+proIco_open+'  data=""></div> '
				    + '              <div class="project-stat-ico icon-company" '+proIco_company+'  data=""></div> '
				    + '              <div class="project-stat-ico icon-unknown" style="display:none"" data=""></div> '
				    + '        </div>'
					+ '	</a>'
					+ '</li>'
					);
					
				}else{
					favoriteS="with-content-star-un";
					favoriteL="with-content-star-2-un";
					$("#projectBoardUl").append(
					"<li id='"+project_id+"' class='project-item ui-state-default'> " 
					+ "	<a class='cursor-pointer'> "
					+ "		<div class='with-content-ct project-badge' style='display: none;'>0</div> "
					+ "		<button class='edit-check with-content-chk' style='display:none;'></button> "
					+ "		<div class='color-code left-menu-type-1 color-"+projectColor+"' data-color='"+projectColor+"'></div> "
  					+ "		<div class='left-menu-type-con'> "
					+ "			<div class='project-star "+favoriteS+"'></div> "
					+ "			<div class='with-content-txt project-ttl'>"+ project_name +"</div> "
					+ "			<div class='with-content-b-c' style='display:block;'> "
					+ "				<div class='with-content-hm-txt'> "
					+ "					<i class='fa-regular fa-user'></i> "
					+ "				</div> "
					+ "				<span class='member-cnt'>"+ projectMemberCount +"</span> "
					+ "				<div class='with-content-fl-r'> "
					+ "                   <div class='project-stat-ico with-content-jms-ico' "+proIco_jms+" data=''></div> "
					+ "                   <div class='project-stat-ico with-content-bl-ico' "+proIco_notice+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-open-project' "+proIco_open+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-company' "+proIco_company+" data=''></div> "
					+ "                   <div class='project-stat-ico icon-unknown' style='display:none' data=''></div> "
					+ "             </div> "
					+ "			</div> "
					+ "		</div> "
					+ "	</a> "
					+ "</li> "
					);
					$("#projectListUl").append(
					'<li id="'+project_id+'" class="project-item">'
					+ '	<a class="cursor-pointer">'
					+ '		<button class="edit-check with-content-chk d-none"></button>'
					+ '		<div class="color-code with-content-list with-content-po-t color-'+projectColor+'"></div>'
					+ '		<div class="project-star with-content-po-t '+favoriteL+'"></div>'
					+ '		<span class="project-ttl">'+ project_name +'</span>'
					+ '		<div class="with-content-hm-txt">'
					+ '			<i class="fa-regular fa-user"></i>'
					+ '		</div>'
					+ '		<span class="member-cnt" style="display:inline-block;">'+ projectMemberCount +'</span>'
					+ '		<strong class="project-badge" style="display:none;">39</strong>'
					+ '		<div class="with-content-fl-r"> '
				    + '              <div class="project-stat-ico with-content-jms-ico" '+proIco_jms+'" data=""></div> '
				    + '              <div class="project-stat-ico with-content-bl-ico" '+proIco_notice+'"  data=""></div> '
				    + '              <div class="project-stat-ico icon-open-project" '+proIco_open+'"  data=""></div> '
				    + '              <div class="project-stat-ico icon-company" '+proIco_company+'"  data=""></div> '
				    + '              <div class="project-stat-ico icon-unknown" style="display:none"" data=""></div> '
				    + '        </div>'
					+ '	</a>'
					+ '</li>'
					);
				}
				
				
				
			}
			if(favoriteCount==0){
				$("#projectBoardUl,#projectListUl").children(".section-1").remove();
			}
		}
	});
}


function personal_project_set_color(pro_id,color){ //즐겨찾기 별 누를때
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 0,
			send_pro_id : pro_id,
			send_color: color
		},
		success: function(){
			
		}
	});
}
function personal_project_set_load_folder(nowId){ //즐겨찾기 별 누를때
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 1,
			send_id : nowId
		},
		success: function(abc){
			var dataList = abc;
//			console.log(dataList);
			$(".label-popup2 .label-set-group").html("");
			for(let i = 0;i<abc.length;i++){
				let folder_id = abc[i].folder_id;
				let folder_name = abc[i].folder_name;
				
				$(".label-popup2 .label-set-group").append(
					'<li class="label-item" data-label-kind="3" folder-id="'+folder_id+'" data-label-ico="4">' 
				    + '    <div class="label-set-item">' 
				    + '        <span class="label-item-text ellipsis">'+folder_name+'</span>' 
				    + '        <a href="#" class="with-content-check-type-1"></a>' 
				    + '    </div>' 
				    + '</li>' 
				);
			}
			
		}
	});
}
function personal_project_folder_set(pro_id,folder_id){
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 2,
			send_projectId:pro_id,
			send_folderId :folder_id
		}
	});
}
function project_push_switch(nowId,pro_id){
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 3,
			send_id:nowId,
			send_pro_id :pro_id
		},
		success: function(abc){
			var dataList = abc;
//			console.log(dataList);
			for(let i=0;i<dataList.length;i++){
				let push_switch = dataList[i].push_switch;
				let push_post = dataList[i].push_post;
				let push_reply = dataList[i].push_reply;
				let notification = dataList[i].notification_list_set;
				$("#pushSettingBtn").removeClass("active");
				if(push_switch==1){
					$("#pushSettingBtn").addClass("active");
				}
				$(".ps1 option[data='"+push_post+"']").attr("selected", "selected");
				$(".ps2 option[data='"+push_reply+"']").attr("selected", "selected");
				if(notification==1){
					$("#relatedAlarm").attr("checked", "checked");
				}else{
					$("#allAlarm").attr("checked", "checked");
				}
			}
		}
	});
}

function project_push_set(nowId,pro_id,push_switch,board_push,reply_push,notification_list){
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 4,
			send_id: nowId,
			send_pro_id: pro_id,
			send_push_switch: push_switch,
			send_board_push: board_push,
			send_reply_push: reply_push,
			send_notification_list: notification_list
		},
		success: function(abc){
		var dataList = abc;
		}
	});
}
function project_hide_set(nowId,pro_id){
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 5,
			send_id: nowId,
			send_pro_id: pro_id
		},
		success: function(){
		}
	});
}
function project_hide_cancel(nowId,pro_id){
	$.ajax({
		url: "pps",
		type: "POST",
		data: {
			send_num: 6,
			send_id: nowId,
			send_pro_id: pro_id
		},
		success: function(){
		}
	});
}
function load_category(nowId){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 1,
			send_id: nowId
		},
		success: function(abc){
			var dataList = abc;
			$("#category select").html("");
			$("#openProjectCategory").html(
				'<li value="0" class="category-item">'
				+ '	<button type="button" class="public-project-item active">전체</button>'
				+ '</li>'
			);
			for(let i=0;i<dataList.length;i++){//프로젝트 생성페이지 카테고리 생성
				let company_id = dataList[i].company_id;
				let category_id = dataList[i].category_id;
				let category = dataList[i].category;
				$("#category select").append(
					'<option id="'+ category_id +'" value="'+ category +'">'+ category +'</option>'
				);
			}
			for(let i=0;i<dataList.length;i++){//공개 프로젝트 카테고리 목록 생성
				let company_id = dataList[i].company_id;
				let category_id = dataList[i].category_id;
				let category = dataList[i].category;
				$("#openProjectCategory").append(
					'<li value="'+category_id+'" class="category-item">'
				+ 	'	<button type="button" class="public-project-item">'+category+'</button>'
				+ 	'</li>'
				);
			}
			
		}
	})
}
function create_project(nowId,title,content,openProject,category_id,project_permission,write,modify,view,reply,file){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 2,
			send_id: nowId,
			send_title: title,
			send_content: content,
			send_openProject: openProject,
			send_category_id: category_id,
			send_project_permission: project_permission,
			send_write: write,
			send_modify: modify,
			send_view: view,
			send_reply: reply,
			send_file: file
		},
		success: function(abc){
			var dataList = abc;
		}
	});
}

function load_my_open_project(nowId,category_id,searchKeyword){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 3,
			send_id: nowId,
			send_category_id: category_id,
			send_searchKeyword: searchKeyword
		},
		success: function(abc){
			var dataList = abc;
			$("#openProjectList").html("");
			let project_count = 0;
			for(let i=0;i<dataList.length;i++){
				project_count +=1;
				let project_id = dataList[i].project_id;
				let project_name = dataList[i].project_name;
				let count_member = dataList[i].count_member;
				let register_id = dataList[i].register_id;
				let joined = dataList[i].joined;
				let joinCom = "none";
				if(joined==1){
					joinCom ="inline-block";
				}
				$("#openProjectList").append(
					'<li value="'+project_id+'" class="project-item"> '
					+ '	<a href="#"> '
					+ '		<div class="project-wr"> '
					+ '			<div class="project-wr-top"> '
					+ '				<i class="sprite-detail icon-locked d-none-important"></i> '
					+ '				<span class="project-ttl">'+project_name+'</span> '
					+ '				<div class="with-content-hm-txt"> '
					+ '					<i class="fa-regular fa-user"></i> '
					+ '				</div> '
					+ '				<em class="participant-count">'+count_member+'</em> '
					+ '				<em class="manager">관리자&nbsp;</em> '
					+ '				<em class="manager-name">'+register_id+'</em> '
					+ '				<em class="badge-join" style="display:'+joinCom+';">참여중</em> '
					+ '			</div> '
					+ '			<p class="project-ttl-sub"></p> '
					+ '		</div> '
					+ '	</a> '
					+ '</li> '
				);
			}
			$("#openProjectTotalCount").html(project_count);
		}
	});
}
function pickProject(nowId,showSelect){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 4,
			send_id: nowId,
			send_showSelect: showSelect
		},
		success: function(abc){
			var dataList = abc;
//			$("#projectBoardUl .project-item,#projectListUl .project-item").each(function(){
//				$(this).hide();
//			});
			if(showSelect=="star"){
				for(let i=0;i<dataList.length;i++){
					let thisId = dataList[i];
					let this1 = "#BoardArea #"+thisId;
					let this2 = "#ListArea #"+thisId;
					$(this1).show();
					$(this2).show();
				}
			}else if(showSelect=="nokeep"){
				for(let i=0;i<dataList.length;i++){
					let thisId = dataList[i];
					let this1 = "#BoardArea #"+thisId;
					let this2 = "#ListArea #"+thisId;
					$(this1).show();
					$(this2).show();
				}
			}else if(showSelect=="hidden"){
				for(let i=0;i<dataList.length;i++){
					let thisId = dataList[i];
					let this1 = "#BoardArea #"+thisId;
					let this2 = "#ListArea #"+thisId;
					$(this1).show();
					$(this2).show();
				}
			}
		}
	});
}


function addEventAjax(nowId) {
    $.ajax({
        url: "ps",
        type: "POST",
        data: {
            send_num: 5,
            send_id: nowId,
        },
        success: function(abc) {
            var dataList = abc;


            var events = [];
            for (let i = 0; i < dataList.length; i++) {
                let title = dataList[i].board_title;
                let start = dataList[i].start_date;
                let deadline = dataList[i].deadline;
				let boardId = dataList[i].board_id;

                events.push({
					id:boardId,
                    title: title,
                    start: start,
                    end: deadline
                });

            }

            // FullCalendar에 이벤트 소스 추가
			calendar.removeAllEvents();
            calendar.addEventSource(events); 
        }
    });
}
function load_board_schedule(board_id,nowId){
	$.ajax({
		url: "ps",
        type: "POST",
        data: {
            send_num: 6,
            send_board_id: board_id,
			send_id:nowId
        },
		success: function(abc){
			var dataList = abc;
			let top = dataList.bsTop;
			let mid = dataList.bsMid;
			let bottom = dataList.bsBottom;
			console.log(dataList);
			//게시글 모달 상단
			$(".card-popup-title span").text(top.project_name);
			$(".card-popup-title span").attr("project_id",top.project_id);
			$(".post-author-info .author").text(top.employee_name);
			$(".post-author-info .author").attr("writer_id",top.employee_id);
			$(".post-author-info .date").text(top.regist_date);
			let scope = '<i class="fa-solid fa-user-group"></i>'
			if(top.public_scope==1){
				scope = '<i class="fa-solid fa-lock"></i>';
			}
			$(".post-security").html(scope);
			$(".post-card-header").attr("board_id",board_id);
			$(".post-title-area .post-title").text(top.board_title);
			$(".schedule-period-start").text(top.start_date);
			$(".schedule-period-end").text(" ㅡ " +top.deadline);
			
			let my_profile = "https://flow.team/flow-renewal/assets/images/profile-default.svg";
			if(top.profile_img!=null){
				my_profile = top.profile_img;
			}
			$(".post-author .thumbnail").css("background-image","url("+my_profile+")");//gg
			if(top.love==1){
				$(".post-bottom-button.love").addClass("on");
			}else{
				$(".post-bottom-button.love").removeClass("on");
			}
			if(top.bookmark==1){
				$(".post-bottom-button.bookmark").addClass("on");
			}else{
				$(".post-bottom-button.bookmark").removeClass("on");
			}
			$("#love_count").text(top.love_count);
			let start_date = top.start_date; //시작일 나눠서 캘린더형식으로 보여줘야햇
			let parts = start_date.split(/[-\s]/); 
			let start_yearMonth = "20" + parts[0] + "-" + parts[1]; 
			let start_day = parts[2]; 
			$(".schedule-month").text(start_yearMonth);
			$(".schedule-day").text(start_day);
//			$(".create-content-area").html("");
//			$(".create-content-area").append(
//				'<div style="width:585px; height:100%; border: 1px solid black; display: inline-block;" class="">' 
//				+'	<img src="https://maps.googleapis.com/maps/api/staticmap?center='+top.lat+','+top.lng+'&amp;zoom=14&amp;size=580x240&amp;maptype=roadmap&amp;markers=color:blue%7C'+top.lat+','+top.lng+'&amp;key=AIzaSyAGqbkrXZ42f8TtH3Sv6Uu4edzDm3EvCoM" alt="지도 이미지" class="">' 
//				+'</div>' 
//			);
			//게시글 모달 상단 끝
			
			//게시글 모달 중단
			let join_ok=0;
			let join_no=0;
			let join_none=0;
			let ujoin = "";
			$(".js-manager-group.manager-group").html("");
			$("#attendanceCount").html("");
			$("#attendanceSelect button").removeClass("on");
			$("#attendanceSelect").hide();
			$(".post-comment-group").html("");
			for(let i=0;i<mid.length;i++){
				let ifMe = 0;
				if(mid[i].employee_id==nowId){
					ifMe = 1;
					$("#attendanceSelect").show();
				}
				if(mid[i].join_case==0){
					join_none+=1;
					ujoin = "undetermined";
					if(ifMe==1){
						$(".attendance-button.undetermined").addClass("on");
					}
				}else if(mid[i].join_case==1){
					join_ok+=1;
					ujoin = "participate";
					if(ifMe==1){
						$(".attendance-button.participate").addClass("on");
					}
				}else if(mid[i].join_case==2){
					join_no+=1;
					ujoin = "absence";
					if(ifMe==1){
						$(".attendance-button.absence").addClass("on");
					}
				}
				
				let profile_img = "https://flow.team/flow-renewal/assets/images/profile-default.svg";
				if(mid[i].profile_img!=null){
					profile_img = mid[i].profile_img;
				}
				$(".js-manager-group.manager-group").append(
					'<span class="js-registration participant-thumbnail attendee '+ujoin+'"data-tippy-content="'+mid[i].employee_name+'" worker-id="'+mid[i].employee_id+'" worker-name="'+mid[i].employee_name+'"'
					+'style="background-image:url('+profile_img+'?width=400&amp;height=400)">'
					+'</span>'
				);
				//style="background-image: url(https://flow.team/flowImg/FLOW_20230720549242_c18ffc61-f710-478b-8d2d-668f979f9e8d.jpeg?width=400&amp;height=400)
			}
			$("#attendanceCount").append(
				'<span class="attendee-status-text participate">'
				+ '	<span>참석</span>'
				+ '	<em>'+join_ok+'</em>'
				+ '</span>'
				+ '<span class="attendee-status-text absence">'
				+ '	<span>불참</span>'
				+ '	<em>'+join_no+'</em>'
				+ '</span>'
				+ '<span class="attendee-status-text undetermined">'
				+ '	<span>미정</span>'
				+ '	<em>'+join_none+'</em>'
				+ '</span>'
			);
			let comment_count = 0;
			for(let i=0;i<bottom.length;i++){
				let profile = "https://flow.team/flow-renewal/assets/images/profile-default.svg";
				comment_count+=1;
				if(bottom[i].reply_profile_img!=null){
					profile = bottom[i].reply_profile_img;
				}
				$(".post-comment-group").append(
					'<li class="remark-item" remark-id="'+bottom[i].reply_id+'" user-id="'+bottom[i].reply_writer+'"> '
					+'	<div class="comment-thumbnail"> '
					+'		<span class="thumbnail size40 radius16" style="background-image: url('+profile+'?width=400&height=400)"> '
					+'		</span> '
					+'	</div> '
					+'	<div class="comment-container on"> '
					+'		<div class="comment-user-area"> '
					+'			<div class="comment-user"> '
					+'				<span class="user-name notranslate">'+bottom[i].reply_writer_name+'</span> '
					+'				<span class="user-position"></span> '
					+'				<span class="record-date">'+bottom[i].reply_regist_date+'</span> '
					+'				<div class="comment-like"> '
					+'					<span class="js-remark-like-button"> '
					+'						<em class="txt-like">좋아요</em> '
					+'					</span> '
					+'					<span class="comment-like-count">'+bottom[i].love_reply_count+'</span> '
					+'				</div> '
					+'			</div> '
					+'			<div class="comment-writer-menu"> '
//					+'				<button type="button" class="remark-update comment-writer-button">수정</button> '
					+'				<button type="button" class="remark-delete comment-writer-button">삭제</button> '
					+'			</div> '
					+'		</div> '
					+'		<div class="comment-content"> '
					+'			<div class="comment-text-area"> '
					+'				<div class="comment-text" style="white-space: normal;"> '
					+'					<div>'+bottom[i].reply_content+'</div> '
					+'				</div> '
					+'			</div> '
					+'		</div> '
					+'	</div> '
					+'</li> '
				);
			}
			$(".comment-count").text(comment_count);
			$(".remark-item").each(function() {
				if($(this).attr("user-id")==nowId){
					$(this).find(".comment-writer-menu button").show();
				}
		    });
		}
	});
}

function update_comment(nowId,comment,board_id,insert,reply_id){ //게시글 모달 댓글 등록 업데이트
	$.ajax({
		url: "ps",
        type: "POST",
        data: {
            send_num: 7,
            send_board_id: board_id,
			send_id:nowId,
			send_comment:comment,
			send_insert:insert,
			send_reply_id:reply_id
        },
		success: function(abc){
			var dataList = abc;
			let comment_count = 0;
			$(".post-comment-group").html("");
			for(let i=0;i<dataList.length;i++){
				let profile = "https://flow.team/flow-renewal/assets/images/profile-default.svg";
				comment_count+=1;
				if(dataList[i].reply_profile_img!=null){
					profile = dataList[i].reply_profile_img;
				}
				$(".post-comment-group").append(
					'<li class="remark-item" remark-id="'+dataList[i].reply_id+'" user-id="'+dataList[i].reply_writer+'"> '
					+'	<div class="comment-thumbnail"> '
					+'		<span class="thumbnail size40 radius16" style="background-image: url('+profile+'?width=400&height=400)"> '
					+'		</span> '
					+'	</div> '
					+'	<div class="comment-container on"> '
					+'		<div class="comment-user-area"> '
					+'			<div class="comment-user"> '
					+'				<span class="user-name notranslate">'+dataList[i].reply_writer_name+'</span> '
					+'				<span class="user-position"></span> '
					+'				<span class="record-date">'+dataList[i].reply_regist_date+'</span> '
					+'				<div class="comment-like"> '
					+'					<span class="js-remark-like-button"> '
					+'						<em class="txt-like">좋아요</em> '
					+'					</span> '
					+'					<span class="comment-like-count">'+dataList[i].love_reply_count+'</span> '
					+'				</div> '
					+'			</div> '
					+'			<div class="comment-writer-menu"> '
//					+'				<button type="button" class="remark-update comment-writer-button">수정</button> '
					+'				<button type="button" class="remark-delete comment-writer-button">삭제</button> '
					+'			</div> '
					+'		</div> '
					+'		<div class="comment-content"> '
					+'			<div class="comment-text-area"> '
					+'				<div class="comment-text" style="white-space: normal;"> '
					+'					<div>'+dataList[i].reply_content+'</div> '
					+'				</div> '
					+'			</div> '
					+'		</div> '
					+'	</div> '
					+'</li> '
				);
			}
			$(".comment-count").text(comment_count);
			$(".comment-input").val("");
			$(".remark-item").each(function() {
				if($(this).attr("user-id")==nowId){
					$(this).find(".comment-writer-menu button").show();
				}
		    });
		}
	});
};

function update_love_bookmark(nowId,board_id,love,bookmark,loveOrBook){ //게시글 모달 댓글 등록 업데이트
	$.ajax({
		url: "ps",
        type: "POST",
        data: {
            send_num: 8,
            send_board_id: board_id,
			send_id:nowId,
			send_love:love,
			send_bookmark:bookmark,
			send_loveOrBook:loveOrBook
        }
	});
}
function choice_join(nowId,board_id,join){ //일정 참여여부 선택
	$.ajax({
		url: "ps",
        type: "POST",
        data: {
            send_num: 9,
			send_id:nowId,
            send_board_id: board_id,
			send_join:join
        }
	});
}
function load_my_folder(nowId){
	$.ajax({
		url: "ps",
        type: "POST",
        data: {
            send_num: 10,
			send_id:nowId
        },
		success: function(abc){
//			console.log(abc);
			$("#allLabelUl").html("");
			for(let i=0;i<abc.length;i++){
				let folder_name = abc[i].folder_name;
				let folder_id = abc[i].folder_id;
				$("#allLabelUl").append(
					' <li label_id="'+folder_id+'"  class="label-item">' 
				    + '    <i class="fa-solid fa-tags" style="color: #999; margin-right:10px;"></i>' 
				    + '    <span class="js-label-name js-mouseover ellipsis">'+folder_name+'</span>' 
				    + '    <a href="#" class="js-label-setting-button flow-dash-three">' 
				    + '    </a>' 
				    + '</li>' 
				);
			}
		}
	});
}

function create_folder(nowId,folder_name){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 11,
			send_id:nowId,
			folder_name:folder_name
		},
		success: function(abc){
			
		}
	});
}

function admin_permission(nowId){
	$.ajax({
		url: "ps",
		type: "POST",
		data: {
			send_num: 12,
			send_id:nowId
		},
		success: function(abc){
			if(abc=="false"){
				$(".admin-btn").hide();
			}else if(abc=="true"){
				$(".admin-btn").show();
			}
			
		}
	});
}
















