/**
 * 
 */

var nowCompany = "";
var calendar;
$(document).ready(function() {
        	var calendarEl = document.getElementById('calendar');
        	 calendarEl.style.width = '100%';
             calendarEl.style.height = '100%';
        	
            calendar = new FullCalendar.Calendar(calendarEl, {
                // Tool Bar 목록 document : https://fullcalendar.io/docs/toolbar
                headerToolbar: {
                    left: 'prevYear,prev,next,nextYear today',
                    center: 'title',
                    right: 'dayGridMonth,dayGridWeek,dayGridDay'
                },
                locale: 'ko',
                selectable: true,
                selectMirror: true,
                editable: false, 

                navLinks: true, // can click day/week names to navigate views
                
                dayMaxEvents: true, // allow "more" link when too many events
                events: [
                    
                ]
            });

            function initializeCalendar() {
                calendar.render();
            }

            function hideCalendar() {
                $('#calendar').hide();
            }

            function showCalendar() {
                $('#calendar').show();
                initializeCalendar();
            }
		    // 이벤트 클릭시 실행할 콜백 함수 등록
		    calendar.on('eventClick', handleEventClick);
		
		
		    // 캘린더 초기화
		    initializeCalendar();

            function handleEventClick(info) { //캘린더 일정 중 선택시 
		        // 클릭한 이벤트의 ID 값 확인
				let board_id = info.event.id;
				$("#postPopup2").show();//일정 게시글 모달 등장
				load_board_schedule(board_id,nowId);//게시글 모달 DB불러와서 입히기
		    }

			$(document).on("click",".card-popup-close",function(){
				$("#postPopup2").hide();
			});
            
            
			$(".left-menu-item").click( function() { //메뉴중 클릭시 페이지 전환,topSettingBar내용 변경.
			if($(this).hasClass("admin-btn")){
				
			}else if($(this).attr("data-code")!="project-more"){
		    		let title = $(this).text();
					$("#mainTop").children().text(title);
					$("#mainContent>div").hide();
					$("#projectHomeTop").hide();
					$("#allCollectView").hide();
					$(".post-search-item").removeClass("highlight");
		            hideCalendar();
					if($(this).attr("data-code")=="main"||$(this).attr("data-code")=="hidden" //projectHomeTop 설정
					   ||$(this).attr("data-code")=="nokeep"||$(this).attr("data-code")=="star"){
					$("#projectHomeTop").show();
					}
					
					if($(this).attr("data-code")=="main"){
						$("#projectHomeLayer").show();
					}else if($(this).attr("data-code")=="open"){
						$("#openProjectLayer").show();
					}else if($(this).attr("data-code")=="task"){
						$("#allCollectView").show();
					}if ($(this).attr("data-code") == "schd") { //캘린더 
						$("#allCollectView").show();
						
			            hideCalendar();
			            showCalendar();
						addEventAjax(nowId);
			        }
					else if($(this).attr("data-code")=="bookmark"||$(this).attr("data-code")=="mention"
							||$(this).attr("data-code")=="mypost"||$(this).attr("data-code")=="tmpPost"){
						$("#allPostsLayer").show();
					}else if($(this).attr("data-code")=="nokeep"||$(this).attr("data-code")=="star" //추가된부분
							||$(this).attr("data-code")=="hidden"){
						$("#projectContentsLayer .middle-line").remove();
						$("#projectHomeLayer").show();
						$(".project-item").each(function(){
							$(this).hide();
						});
					}
					
				}
	       });
			
			
			$(document).on("mouseover",".js-registration",function(){
				tippy('.js-registration',{
				placement:'top'
				});
			});
			$(document).on("click",".label-item",function(){ // 프로젝트 폴더쪽 클릭하면 left-menu 부분 active 사라지고 해당 폴더로 이동
		    	$(".left-menu-item").removeClass("with-active");
		    	$("#mainContent>div").hide();
		    	$("#projectHomeLayer").show();
		    	let title = $(this).text();
		    	$("#mainTop").children().text("프로젝트 폴더 - "+title)
		    });
			
        });

function openOp() {
	var b1 = document.getElementById('openOption');
	b1.style.display = 'none';
	var b2 = document.getElementById('closeOption');
	b2.style.display = 'block';
	var b3 = document.getElementById('addOption');
	b3.style.display = 'block';
}
function closeOp() {
	var b1 = document.getElementById('openOption');
	b1.style.display = 'block';
	var b2 = document.getElementById('closeOption');
	b2.style.display = 'none';
	var b3 = document.getElementById('addOption');
	b3.style.display = 'none';
}
let s = 0;
function openCategory(){
		if(s==0){
		var b1 = document.getElementById('category');
		b1.style.display = 'block';
		s+=1;
		}
		else{
		var b1 = document.getElementById('category');
		b1.style.display = 'none';
		s-=1;
		}
		
}

		
 $(function(){ //
	
	
	
	
	$("#createLabel .submit-event1").click(function(){ //폴더만들기
		if($(".popup-input").val()==""){
			alert("폴더명을 입력해주세요.");
		}else{
			let folder_name = $(".popup-input").val();
			create_folder(nowId,folder_name);
			setTimeout(function(){
			load_my_folder(nowId);
			},10);
		}
	});
	
	$(document).on("click",".project-item,#RecentProjectUl li",function(){
		if($("#totalProjectEditBar").css("display")=="none"){
			$("#mainTop").hide();
			$("#projectHomeTop").hide();
			$("#projectHomeLayer").hide();
			$(".project-detail-top").show();
			$("#detailLayer").show();
			$("#detailTimeline").show();
			$("#detailTop").show();
		}
	});
	$(document).on("click",".project-item",function(){
		if($("#totalProjectEditBar").css("display")=="none"){
			let project_id = $(this).attr("id");
			let project_title = $(this).find(".with-content-txt").text();
			let project_color = "color-code-"+$(this).find(".color-code").attr("data-color");
			$("#projectTitle").attr("project_id",project_id);
			$("#projectTitle").text(project_title);
		    $("#projectColor").attr("class", "project-color " + project_color); 
   		    $("#projectFeedArea").empty();
   		    $("#participantsUl").empty();
			load_board(project_id);
			load_member(project_id);
		}
	});
	


	$(".admin-btn").click(function(){
		window.open("어드민_회사정보.jsp", "_blank");
	});
	
	$(".pay-button").click(function(){
		location.href="위드결제.jsp";
	});
	
	$(document).on("click",".attendance-button",function(){
		let join = 0;
		let board_id = $(".post-card-header").attr("board_id");
		$(".attendance-button").removeClass("on");
		$(this).addClass("on");
		if($(this).hasClass("participate")){
			join = 1;
		}else if($(this).hasClass("absence")){
			join = 2;
		}
		choice_join(nowId,board_id,join);
		setTimeout(function(){
			load_board_schedule(board_id,nowId);
		},10);
	});
	
	

	$(document).on("click",".post-bottom-button",function(){//스케줄 모달 좋아요,북마크 
		let love = 0;
		let bookmark = 0;
		let board_id = $(".post-card-header").attr("board_id");
		let love_count;
		let loveOrBook = 0;
		love_count = parseInt($("#love_count").text(), 10);
		if($(".post-card-header.love").hasClass("on")){
			love = 1;
		}
		if($(".post-card-header.bookmark").hasClass("on")){
			bookmark = 1;
		}
		if($(this).hasClass("love")){
			loveOrBook = 0;
			if($(this).hasClass("on")){
				love = 0;
				$(this).removeClass("on");
				love_count -=1;
				$("#love_count").text(love_count);
			}else if(!$(this).hasClass("on")){
				love = 1;
				$(this).addClass("on");
				love_count +=1;
				$("#love_count").text(love_count);
			}
		}else if($(this).hasClass("bookmark")){
			loveOrBook = 1;
			if($(this).hasClass("on")){
				bookmark = 0;
				$(this).removeClass("on");
			}else if(!$(this).hasClass("on")){
				bookmark = 1;
				$(this).addClass("on");
			}
		}
		update_love_bookmark(nowId,board_id,love,bookmark,loveOrBook);
	});
			
	$(document).on("click","#comment-btn-final",function(){//스케줄 댓글 작성 및 로드
			let comment = $(".comment-input").val();
			let board_id = $(".post-card-header").attr("board_id");
			update_comment(nowId,comment,board_id,1,0);//1이면 insert
    });
	$(document).on("click",".js-remark-like-button",function(){
		let reply_id = $(this).parent().parent().parent().parent().parent().attr("remark-id");
		let board_id = $(".post-card-header").attr("board_id");
		update_comment(nowId,"",board_id,2,reply_id);//2면 댓글 좋아요 insert
	});
	
	$("#toggle2").click(function(){
		if($("#toggle2").hasClass("act")){
			$("#toggle2").removeClass("act");
		}else{
			$("#toggle2").addClass("act");
			
		}
	});
	$("#toggle").click(function(){
		if($("#toggle").hasClass("act")){
			$("#toggle").removeClass("act");
		}else{
			$("#toggle").addClass("act");
		}
	});
	$("#openOption,#closeOption").click(function(){
		if($("#openOption").hasClass("act")){
			$("#openOption").removeClass("act");
		}else{
			$("#openOption").addClass("act");
		}
	});
	
		let showSelect = "";
	$(".left-more-menu button,.left-menu-item").click( function(){//미분류,즐겨찾기,숨김 프로젝트 로드
		$("#mainTop").show();
		$(".project-detail-top").hide();
		$("#detailTimeline").hide();
		$("#detailTop").hide();
		if($(this).attr("data-code")=="star"){
			showSelect = "star";
			pickProject(nowId,showSelect);
		}else if($(this).attr("data-code")=="hidden"){
			showSelect = "hidden";
			pickProject(nowId,showSelect);
		}else if($(this).attr("data-code")=="nokeep"){
			showSelect = "nokeep";
			pickProject(nowId,showSelect);
		}
		
	});
	
	$(document).on("click","#letsgogo",function(){ //프로젝트 만들기
		let title = $("#projectTitleInput").val();
		let content = $("#projectContentsInput").val();
		let openProject = 1;
		let category_id = 1;
		let project_permission = 0;
		let write = 0;
		let modify =0;
		let view = 0;
		let reply = 0;
		let file = 0;
		
		if(title==""||content==""){
			$("#toastPopup .text").html("프로젝트 제목과 설명을 모두 입력하세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1500);
		}else{
			if($("#toggle").hasClass("act")){
				openProject = 2;
				category_id = $("#category option:selected").attr("id");
			}
			if($("#toggle2").hasClass("act")){
				project_permission = 1;
			}
			if($("#openOption").hasClass("act")){
				write = $("#writePermission option:selected").val();
				modify = $("#modifyPermission option:selected").val();
				view = $("#viewPermission option:selected").val();
				reply = $("#replyPermission option:selected").val();
				file = $("#filePermission option:selected").val();
			}
			create_project(nowId,title,content,openProject,category_id,project_permission,write,modify,view,reply,file);
			$("#projectTitleInput").val("");
			$(".project-template-main").css("display","none");
			$("#allMainContent").css("display","block");
			setTimeout(function(){
			load_myProject(nowId,0,0);
			},10);
			
		}
	});
	
	$(document).on("click","#createProjectButton",function(){
		load_category(nowId);
	});
	
			
	//프로젝트 만들기
	$("#projectMakeButton").click(function(){ //프로젝트 판들기1
		$(".project-template-intro").css("display","block");
	});
	$("#createProjectButton").click(function(){
		$(".project-template-intro").css("display","none");
		$("#allMainContent").css("display","none");
		$(".project-template-main").css("display","block");
	});
	$("#projectSectionClose").click(function(){
		$("#allMainContent").css("display","block");
		$(".project-template-main").css("display","none");
	});
	$("#templateReturnButton").click(function(){
		$(".project-template-main").css("display","none");
		$(".project-template-intro").css("display","block");
	});

	//프로젝트 만들기		    
	 		
	$("#menu11 li").click(function(){// 모아보기 - 포스트 메뉴 클릭 시 
	$("#totalProjectEditBar").css("display","none");
	$("#projectBoardUl .active,#projectListUl .active").removeClass("active");
	$(".edit-check").css("display","none");
	$(".select-count").html("0개 프로젝트가 선택되었습니다.");
	chooseProject=0;
	$("#postCount").html("");
	 $(".check-menu-item[data-code='-1']").css("display", "none");//댓글 필터 끔
	$("#myPostContentUl").html("");
		if($(this).attr("data-code")=="mypost"){// 내 게시물
			load_my_board(nowId,0);
		}
		else if($(this).attr("data-code")=="mention"){// 나를 언급
			 $(".check-menu-item[data-code='-1']").css("display", "block");
			load_my_mention(nowId,0);
		}else if($(this).attr("data-code")=="bookmark"){// 북마크
			load_my_bookmark(nowId,0);
		}else if($(this).attr("data-code")=="tmpPost"){// 임시저장
			load_my_tempsave(nowId,0);
		}
	});	
	
	
	
	$(document).on("click",".check-menu-item",function(){
		$("#myPostContentUl").html("");
			let bType = $(this).attr("data-code");
		if($("#menu11").find(".with-active").attr("data-code")=="mypost"){
			load_my_board(nowId,bType);
		}else if($("#menu11").find(".with-active").attr("data-code")=="mention"){
			load_my_mention(nowId,bType);
		}else if($("#menu11").find(".with-active").attr("data-code")=="bookmark"){
			load_my_bookmark(nowId,bType);
		}else if($("#menu11").find(".with-active").attr("data-code")=="tmpPost"){
			load_my_tempsave(nowId,bType);
		}
	});
	 $(document).on("click",".recent-project-item",function(){
		$("#allPostsLayer").hide();
	});

	$(".my-project").click(function(){
		load_myProject(nowId,0,0);
	});
	
	load_myProject(nowId,0,0);//최초 진입 시 내 프로젝트 불러오기
	setTimeout(function(){
	admin_permission(nowId);
	},10);
	load_my_folder(nowId);
	
	
	var thisOrder = 0;
	var thisFilter = 0;
	$(document).on("click",".project-star",function(event){ //프로젝트 즐겨찾기 버튼 상호작용
		event.stopPropagation();
		if($("#totalProjectEditBar").css("display")=="block"){
		}else{
			let proId = 0;
			if($(this).hasClass("with-content-po-t")){
				proId = $(this).parent().parent().attr("id");
			}else{
				proId = $(this).parent().parent().parent().attr("id");
			}
			let nowFavorite = 0;
			if($(this).hasClass("with-content-star-un")||$(this).hasClass("with-content-star-2-un")){
				nowFavorite = 0;
			}else{
				nowFavorite = 1;
			}
			
			thisIsMyFavorite(nowId,proId,nowFavorite);
			setTimeout(function(){
			load_myProject(nowId,thisOrder,thisFilter);
			},10);
			return false;
		}
		
		
	});
	
	$(document).on("click",".order-item,.filter-item",function(){ //프로젝트 내 정렬, 필터
		thisOrder = $(".menu-popup-t-1").children(".on").attr("code");
		thisFilter = $(".menu-popup-t-2").children(".on").attr("code");
		load_myProject(nowId,thisOrder,thisFilter);
		
	});
	
	$(document).on("click",".color-popup2 .submit-event",function(){//프로젝트 색상변경
		$("#projectBoardUl .active,#projectListUl .active").each(function(){
			let thisId = $(this).attr("id");
			let thisColor = $(".project-color-check-active-1").attr("color-code");
			personal_project_set_color(thisId,thisColor);
			load_project(nowId);
			$(".color-popup2,.with-all-background-1").css("display","none");
			for(let i=0;i<=11;i++){
				$(this).find(".color-code").removeClass("color-"+i);
			}
			$(this).find(".color-code").addClass("color-"+thisColor);
			$("#toastPopup .text").html("적용되었습니다.");
				$("#toastPopup").css("display","block")
				setTimeout(function() {
			      $("#toastPopup").css("display", "none");
			    }, 1500);
		});
		
	});
	
	
	
	
	
	
	
		
	
	$(document).on("click",".type-button",function(){ //내 프로젝트 topsettingbar 바둑판/리스트형 버튼
		$(".type-button").removeClass("on");
		$(this).addClass("on");
		if($("#BoardTypeButton").hasClass("on")){
			$("#BoardArea").show();
			$("#ListArea").hide();
		}else if($("#ListTypeButton").hasClass("on")){
			$("#ListArea").show();
			$("#BoardArea").hide();
		}
	});
	
	$("#totalProjectEditButton").click(function(){ //프로젝트 설정 버튼
		$("#totalProjectEditBar").css("display","block");
		$(".edit-check").css("display","block");
		if($(".with-active").attr("data-code")=="hidden"){
			$(".edit-button.hidden").css("display","none");
			$(".edit-button.hidden2").css("display","inline-block");
		}else{
			$(".edit-button.hidden2").css("display","none");
			$(".edit-button.hidden").css("display","inline-block");
		}
	});
	$(".select-clear").click(function(){
		$(".project-group li,.section-list-1 li").removeClass("active");
		chooseProject = 0;
		$("#totalEditSelect .select-count").text(chooseProject+"개 프로젝트가 선택되었습니다.");
	});
	var chooseProject = 0;
 	$(document).on("click", ".project-group li,.section-list-1 li", function(){
 		if($("#totalProjectEditBar").css("display")=="block"){
	 			if($(this).hasClass("active")){
	 			$(this).removeClass("active");
	 			chooseProject-=1;
	 			}else{
	 			$(this).addClass("active");
	 			chooseProject+=1;
	 			}
	 			$("#totalEditSelect .select-count").text(chooseProject+"개 프로젝트가 선택되었습니다.");
	 			
 		}
 	});
 	
 	$(".with-content-ct").each(function() {
	   	if($(this).text()==0){
	   		$(this).hide();
	   	}else{
	   		$(this).show();
	   	}
	  });
 	
 	
 	
	$("#editBarCloseButton").click(function(){ //프로젝트 설정 버튼
		$("#totalProjectEditBar").css("display","none");
		$(".edit-check").css("display","none");
		$(".project-group li,.section-list-1 li").removeClass("active");
		$("#totalEditSelect .select-count").text(0+"개 프로젝트가 선택되었습니다.");
		chooseProject=0;
	});
	$(".order-item").click(function(){ // 정렬 내 선택
		$(".order-item").removeClass("on");
		$(this).addClass("on");
	});
	$(".filter-item").click(function(){ // 정렬 내 선택2
		$(".filter-item").removeClass("on");
		$(this).addClass("on");
	});
	$("#projectOrderButton").click(function(){ // 프로젝트 정렬 버튼
		$("#projectOrderList").css("display","block");
	});
	$(document).click(function(event) {
	  if (!$(event.target).closest('#projectOrderButton').length) {
	    // 클릭된 요소가 projectOrderButton 이외의 다른 곳에 속한다면
	    if ($('#projectOrderList').css('display') === 'block') {
	      // projectOrderList가 표시된 상태라면 display 속성을 none으로 변경
	      $('#projectOrderList').css('display', 'none');
	    }
	  }
	});
	
	//색상설정
	$("#totalEditButton .color").click(function(){
		if($("#projectBoardUl,#projectListUl").find(".active").length>0){
		$(".with-all-background-1").css("display","block");
		$(".color-popup2").css("display","block");
		}else{
			$("#toastPopup .text").html("프로젝트를 선택해주세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1000);
		}
	});
	$("#totalEditButton .label").click(function(){ //폴더설정
		if($("#projectBoardUl,#projectListUl").find(".active").length>0){
		$(".with-all-background-1").css("display","block");
		$(".label-popup2").css("display","block");
		personal_project_set_load_folder(nowId);
		}else{
			$("#toastPopup .text").html("프로젝트를 선택해주세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1000);
		}
	});
	$(document).on("click",".label-popup2 .submit-event",function(){//폴더설정 db반영
		let thisFolderId = $(".with-content-check-type-2").parent().parent().attr("folder-id");
		if($(".label-set-group").find(".with-content-check-type-2").length>0){
			$("#projectBoardUl .active,#projectListUl .active").each(function(){//선택한폴더 있을때
				let thisId = $(this).attr("id");
				personal_project_folder_set(thisId,thisFolderId);
				$("#toastPopup .text").html("적용되었습니다.");
//				if($(".with-active").attr("data-code")=="nokeep"){
//					$(this).hide();
//				}
				$("#toastPopup").css("display","block")
				setTimeout(function() {
			      $("#toastPopup").css("display", "none");
			    }, 1500);
			});
			
		}else{
			$("#projectBoardUl .active,#projectListUl .active").each(function(){//선택한 폴더 없으면 폴더 없앰
				let thisId = $(this).attr("id");
				personal_project_folder_set(thisId,0);
				$("#toastPopup .text").html("선택한 프로젝트의 폴더설정을 초기화 하였습니다.");
				$("#toastPopup").css("display","block")
				setTimeout(function() {
			      $("#toastPopup").css("display", "none");
			    }, 1500);
			});
		}
		
		$(".label-popup2,.with-all-background-1").css("display","none");
	});
	
	
	
	
	
	$("#totalEditButton .push").click(function(){//프로젝트 알림설정
		if($("#projectBoardUl,#projectListUl").find(".active").length==1){
		let pro_id = $("#projectContentsLayer .active").attr("id");
		project_push_switch(nowId,pro_id);
		$(".with-all-background-1").css("display","block");
		$(".push-alarm-popup2").css("display","block");
		}else if($("#projectBoardUl,#projectListUl").find(".active").length>1){
			$("#toastPopup .text").html("프로젝트를 하나만 선택해주세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1000);
		}else{
			$("#toastPopup .text").html("프로젝트를 선택해주세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1000);
		}
	});
	
	$(document).on("click", "#pushSettingBtn", function() { //그 알림 푸시 끄고 키는 스위치
	  if ($(this).hasClass("active")) {
	    $(".push-selected").removeAttr("disabled");
	  }else {
	    $(".push-selected").attr("disabled", "disabled");
	  }
	});
	
	$(document).on("click",".push-alarm-popup2 .submit-event",function(){ //알림설정 값 바꾸고 확인버튼 눌렀을 때  submit event
		let push_switch = 0;
		let board_push = $(".push-selected.ps1 option:selected").attr("data");
		let reply_push = $(".push-selected.ps2 option:selected").attr("data");
		let notification_list = 0;
		if($("#pushSettingBtn").hasClass("active")){
			push_switch = 1;
			$("#projectContentsLayer .active").find(".with-content-bl-ico").css("display","none");
		}else if(!$("#pushSettingBtn").hasClass("active")){
			$("#projectContentsLayer .active").find(".with-content-bl-ico").css("display","inline-block");
		}
		if($("input[name='alarm']:checked").attr("id")!="allAlarm"){
			notification_list = 1;
		}
		let pro_id = $("#projectContentsLayer").find(".active").attr("id");
		project_push_set(nowId,pro_id,push_switch,board_push,reply_push,notification_list);

		$(".push-alarm-popup2,.with-all-background-1").css("display","none");

		$("#toastPopup .text").html("적용되었습니다.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1500);
	});
	
	
	
	
	$("#totalEditButton .hidden,#totalEditButton .hidden2").click(function(){//숨김, 숨김취소
		if($("#projectBoardUl,#projectListUl").find(".active").length>0){
		$(".with-all-background-1").css("display","block");
		$(".confirm-popup2").css("display","block");
			if($(".with-active").attr("data-code")=="hidden"){
				$(".confirm-popup2 .popup-cont").text("해당 프로젝트를 숨김 취소 하시겠습니까?");
			}else{
				$(".confirm-popup2 .popup-cont").text("해당 프로젝트를 숨기시겠습니까?");
			}
		}else{
			$("#toastPopup .text").html("프로젝트를 선택해주세요.");
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1000);
		}
	});
 		
	$(document).on("click",".confirm-popup2 .submit-event",function(){ //숨김 submit event
		if($(".with-active").attr("data-code")=="hidden"){
			$("#projectBoardUl .active,#projectListUl .active").each(function(){
				$(this).css("display","none");
				let siva = $(this).attr("id");
				$("#projectListUl #"+siva).css("display","none");
				let pro_id = $(this).attr("id");
				project_hide_cancel(nowId,pro_id);
			
			});
		}else{
			$("#projectBoardUl .active,#projectListUl .active").each(function(){
				$(this).css("display","none");
				let siva = $(this).attr("id");
				$("#projectListUl #"+siva).css("display","none");
				let pro_id = $(this).attr("id");
				project_hide_set(nowId,pro_id);
			
			});
		}
		$(".confirm-popup2,.with-all-background-1").css("display","none");
		$(".select-count").html("0개 프로젝트가 선택되었습니다.");
		$("#toastPopup .text").html("적용되었습니다.");
		chooseProject=0;
			$("#toastPopup").css("display","block")
			setTimeout(function() {
		      $("#toastPopup").css("display", "none");
		    }, 1500);
	});
	
	
	
	$(".close-event").click(function(){
		$(".with-all-background-1").css("display","none");
		$(this).parent().parent().css("display","none");
	});
	$(".cancel-event").click(function(){
		$(".with-all-background-1").css("display","none");
		$(this).parent().parent().parent().css("display","none");
	});
	
	//색상설정 내 선택
	$("#selectColorTypes li").click(function(){
		$("#selectColorTypes li").removeClass("project-color-check-active-1");
		$(this).addClass("project-color-check-active-1");
	});
	
	 $("#openProjectSearchInput").on("keyup",function(key){
        if(key.keyCode==13) {
			let searchKeyword = $("#openProjectSearchInput").val();
			load_my_open_project(nowId,0,searchKeyword);
        }
    });
	
	$(document).on("click",".label-set-group li",function(){ //프로젝트설정 
 			$(".label-set-group li").children().children("a").removeClass();
			$(".label-set-group li").children().children("a").addClass("with-content-check-type-1");
		if($(this).find(".with-content-check-type-1").length>0){
 			$(this).children().children("a").removeClass("with-content-check-type-1");
 			$(this).children().children("a").addClass("with-content-check-type-2");
		}else{
 			$(this).children().children("a").removeClass("with-content-check-type-2");
 			$(this).children().children("a").addClass("with-content-check-type-1");
		}
	});

	//공개프로젝트
	$("#glass").click(function(){
		load_category(nowId); //공개프로젝트 드가면 카테고리들 떠야해
		load_my_open_project(nowId,0,null);
	});
	$(document).on("click","#openProjectCategory button",function(){ //공개프로젝트 카테고리 누르면
		$("#openProjectCategory button").removeClass("active");
		$(this).addClass("active");
		let category_name = $(this).text();
		let category_id = $(this).parent().val();
		load_my_open_project(nowId,category_id,null);
		$("#openProjectCategoryName").html(category_name);
		
	});
	$("#openProjectSearchInput").on('input',function(){ //검색란 값 있을 때 없을 때 버튼 활성/비활성
		if($("#openProjectSearchInput").val()==''){
			$(".btn-search-delete.absolute-r").css("display","none");
		}else{
			$(".btn-search-delete.absolute-r").css("display","block");
		}
	});
	
	$(".btn-search-delete.absolute-r").on("click",function(){ //검색창 입력값 삭제버튼
		$("#openProjectSearchInput").val('');
		$(this).css("display","none");
	});
	
	$("#openProjectCategory .category-item").on("click",function(){ //카테고리 선택 active css 
		$("#openProjectCategory .category-item").children().removeClass("active");
		$(this).children().addClass("active");
		let categoryText = $(this).children().text();
		$("#openProjectCategoryName").text(categoryText+" 회사 공개 프로젝트");
	});

	//post - 북마크,나를엄급,내게시물,임시저장 검색창
	$("#allPostsSearchInput").on('input',function(){ //검색란 값 있을 때 없을 때 버튼 활성/비활성
		if($("#allPostsSearchInput").val()==''){
			$(".btn-search-delete").css("display","none");
		}else{
			$(".btn-search-delete").css("display","block");
		}
	});
	
	$(".btn-search-delete").on("click",function(){ //검색창 입력값 삭제버튼
		$("#allPostsSearchInput").val('');
		$(this).css("display","none");
	});
	
	$(document).ready(function() { //post 검색 옵션
	    $("#allPostsDetailSearchTopButton").click(function(){
	        $("#allPostsDetailSearchLayer").show();
	        
	        $(document).on("click", function(event) {
	            if (!$(event.target).closest("#allPostsDetailSearchLayer").length && !$(event.target).is("#allPostsDetailSearchTopButton")) {
	                $("#allPostsDetailSearchLayer").hide();
	            }
	        });
			$(".condition-right .cancel").click(function(){
				$("#allPostsDetailSearchLayer").hide();
			});
			
	    });
	});
	
	$("#allPostsFilter button").click(function(){
		$("#allPostsFilter .my-popup").show();
	});
	
	$("#allPostsFilter .check-menu-item").click(function(){
		$(".check-menu-item").removeClass("on");
		$(this).addClass("on");
		
		let postTitle = $(this).text();
		$("#allPostsFilterTitle").text(postTitle);
		
		$("#allPostsFilter .my-popup").hide();
	});
	
	
	$("#myPostContentUl .post-search-item").click(function(){
		$(".post-search-item").removeClass("highlight");
		$(this).addClass("highlight");
	});
		
		
	
	
	
 });



















