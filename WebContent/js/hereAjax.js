function load_list(searchInput,nowId){
	$.ajax({
		url:"BoardServlet",
		type:"POST",
		data:{
			send_searchInput : searchInput,
			send_nowId : nowId
		},
		success: function(abc){
			var data1 = abc;
			console.log(data1);
			for(let i=0;i<data1.length;i++){
				let title = data1[i].title;
				let content = data1[i].content;
				let writer = data1[i].writer;
				let writedate = data1[i].writedate;
				let tabletype = data1[i].tabletype;
				$("#projectSearchResult").append(
				'<li class="post-search-item js-search-item highlight" data-code="post" colabo_srno="1887714" colabo_commt_srno="31032657" colabo_remark_srno="68012894" rgsn_dttm="20230714094213"> '
			     +'   <i class="icon-post-type comment" style="float:left;"></i> '
			     +'   	<div class="search-sub-text-wrap"> '
            	 +'			<a href="#" class="search-text-type-3 contents-tit"> '
                 +' 	<p style="margin:0;"><span class="post-name-txt">'+tabletype+'</span><strong>'+content+'</strong></p> '
           	     +'	</a>  '
            	 +'	<p class="search-text-type-3 contents-project" style="margin:0;"> '
                 +'	<span class="search-name ellipsis">'+writer+'</span> <span class="date">'+writedate+'</span> '
           		 +'	</p> '
        		 +'	</div> ' 
				 +'	</li> '  
				);
			}
		}		
	});
};
function load_board(project_id){
    $.ajax({
        url:"AllBoardServlet",
        type:"POST",
        data:{
            send_projectId : project_id
        },
       		success: function(data) {
			    var hkbkbk = data.b;
			    var hkbkbk1 = data.b1;
			    var hkbkbk2 = data.b2;
			    var hkbkbk3 = data.b3;
			    var hkbkbk4 = data.b4;
				let a = 0;
				let b = 0;
				let c = 0;
				let d = 0;
				const titleIds = new Set(); 
            for(let i = 0; i < hkbkbk.length; i++){
				  if (i > 0 && hkbkbk[i].title1 === hkbkbk[i - 1].title1) {
			        continue;
			    }
				let type = hkbkbk[i].Type;
                if(type == 1){
				let title = hkbkbk[i].title1;
				let content = hkbkbk[i].content1;
				let boardwriter = hkbkbk[i].boardwriter1;
				let registdate = hkbkbk[i].registdate1;
				let jobtitle = hkbkbk[i].jobTitle;
				let replywriter = hkbkbk[i].replywriter;
				let replycontent = hkbkbk[i].replycontent;
				let replydate = hkbkbk[i].replydate;
				let like = hkbkbk[i].like;
				let replylike = hkbkbk[i].replylike;
				let like1 = "";
				let reply1 = "";
				let postCardFooter = '';
				 if (like) {
		            like1 = "on";
		        }
				if(replylike) {
						reply= "1";				
				}
				if(replywriter) {
					postCardFooter =`
									<li class="remark-item" remark-srno="70068272" data-user-id="a13sdf@naver.com">
							          <div class="comment-thumbnail js-comment-thumbnail">
							              <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
							          </div>
							          <div class="js-remark-view comment-container on ">
							              <div class="comment-user-area">
							                  <div class="comment-user">
							                      <span class="user-name js-comment-user-name notranslate">`+replywriter+`</span>
							                      <span class="user-position"></span>
							                      <span class="record-date">`+replydate+`</span>
							                      <div class="js-remark-like comment-like">
							                          <span class="js-remark-like-button"><em class="txt-like">좋아요</em></span>
							                          <span class="js-remark-like-count comment-like-count">`+ reply1+`</span>
							                      </div>
							                  </div>
							                  <div class="comment-writer-menu">
							                      <button type="button" class="js-remark-update js-remark-edit-button comment-writer-button on">
							                          수정</button>
							                      <button type="button" class="js-remark-delete js-remark-edit-button comment-writer-button on">
							                          삭제</button>
							                  </div>
							                </div>
							              <div class="js-remark-layer comment-content">
							                  <div class="comment-text-area">
							                      <div class="js-remark-text comment-text"><div>`+replycontent+`</div></div>
							                  </div>
							              </div>
							          </div>
							      </li>										
				`;
				}
				$("#projectFeedArea").append(
				'<div class="post-card-header immutable">  '
                +'   <div class="post-card-scroll"> '
                +'        <div class="card-header-top"> '
                +'            <div class="post-author main js-post-author" data-author-id="hkbk00@gmail.com"> '
                +'                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>  '
                +'                <dl class="post-author-info">  '
                +'                    <dt> '
                +'                        <strong class="author ellipsis notranslate">'+boardwriter+'</strong> '
                +'                        <em class="position ellipsis" style="display:inline" data="">'+jobtitle+'</em> '
                +'                        <span class="date">'+registdate+'</span> '
                +'                        <span class="post-security" style="display:inline" data=""> <i class="fa-solid fa-users" style="color:#aaa"></i></span> '
                +'                    </dt> '
                +'                    <dd class="d-block"> '
                +'                        <strong class=""></strong> '
                +'                        <span class="team"></span> '
                +'                    </dd> '
                +'                </dl> '
                +'            </div> '
                +'            <div> '
                +'                <div class="post-option"> '
                +'                    <button id="pinToTopBnt" class="js-pin-post fixed-btn js-pin-authority " style="display:block" data=""> '
                +'                        <span class="blind">상단 고정 등록</span> '
                +'                    </button> '
                +'                    <button class="js-setting-button set-btn"> '
                +'                        <span></span> '
                +'                        <span></span> '
                +'                        <span></span> '
                +'                    </button> '
                +'                    <ul class="js-setting-ul js-setting-layer setup-group d-none"> '
                +'                        <li class="js-setting-item" data-code="modify" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-write"></i>수정 '
                +'                                <i class="edit-auth-icon icons-question js-mouseover d-none" mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display:none" data=""></i> '
                +'                            </a> '
                +'                        </li> '
                +'                        <li class="js-setting-item" data-code="copy" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-project-1"></i>다른 프로젝트에 복사</a> '
                +'                        </li><li class="js-setting-item" data-code="url" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-copy"></i>링크 복사</a> '
                +'                        </li> '
                +'                        <li class="js-setting-item" data-code="delete" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-delete-3"></i>삭제</a> '
                +'                        </li> '
                +'                    </ul> '
                +'                </div> '
                +'            </div> '
                +'        </div> '
                +'        <div class="card-header-bottom"> '
                +'            <div class="post-title-area"> '
                +'                <h4 class="post-title">'+title+'</h4> '
                +'            </div> '
                +'        </div> '
                +'        <div class="post-card-container"> '
				+'        <div id="originalPost" class="post-card-content " style="display:block" contenteditable="false"><div>'+content+'</div></div> '
                +'            <div class="post-bottom-area"> '
                +'                <div class="post-bottom-menu js-reaction-bookmark"> '
                +'                    <div class="bottom-button-area"> '
                +'                        <button class="js-post-reaction post-bottom-button '+ like1+'"> '
                +'                            <i class="icon-reaction"></i> '
                +'                            <span>좋아요</span> '
                +'                        </button> '
                +'                        <button class="js-post-bookmark post-bottom-button "> '
                +'                            <i class="icon-bookmark"></i> '
                +'                            <span>북마크</span> '
                +'                        </button> '
                +'                    </div> '
                +'                </div> '
                +'                <div class="cmt-read-wr"> '
                +'                    <div class="comment-count-area"> '
                +'                        <span>댓글</span> '
                +'                        <span class="comment-count">0</span> '
                +'                    </div> '
                +'                    <div class="js-read-check-button read-confirmation" style="display:block" data=""> '
                +'                        <span>읽음</span> '
                +'                        <span class="confirmation-number">1</span> '
                +'                    </div> '
                +'                </div> '
                +'            </div> '
                +'        </div> '
                +'        <div class="post-card-footer"> '
                +'            <div class="comment-header"> '
                +'            </div> '
				+'				<ul class="post-comment-group"> '
				+				postCardFooter
				+'				</ul> '
                +'        </div> '
                +'        <div class="js-remark-layer js-edit-layer comment-input-wrap"> '
                +'            <div class="comment-thumbnail"> '
                +'                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span> '
                +'            </div> '
                +'            <form class="js-remark-form comment-container on " spellcheck="false"> '
                +'                <fieldset> '
                +'                    <legend class="blind">댓글 입력</legend> '
                +'                    <div class="js-remark-area js-paste-layer comment-input" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div> '
                +'                </fieldset> '
                +'            </form> '
                +'        </div> '
                +'    </div> '
                +' </div> '
				);
                }
                if(type == 2){
				let title = hkbkbk[i].title1;
				let content = hkbkbk[i].content1;
				let boardwriter = hkbkbk[i].boardwriter1;
				let registdate = hkbkbk[i].registdate1;
				let jobtitle = hkbkbk[i].jobTitle;
				let replywriter = hkbkbk[i].replywriter;
				let replycontent = hkbkbk[i].replycontent;
				let replydate = hkbkbk[i].replydate;
				let like = hkbkbk[i].like;
				let replylike = hkbkbk[i].replylike;
				let like1 = "";
				let reply1 = "";
				let postCardFooter = '';
				 if (like) {
		            like1 = "on";
		        }
				if(replylike) {
						reply= "1";				
				}
				if(replywriter) {
					postCardFooter =`
									<li class="remark-item" remark-srno="70068272" data-user-id="a13sdf@naver.com">
							          <div class="comment-thumbnail js-comment-thumbnail">
							              <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
							          </div>
							          <div class="js-remark-view comment-container on ">
							              <div class="comment-user-area">
							                  <div class="comment-user">
							                      <span class="user-name js-comment-user-name notranslate">`+replywriter+`</span>
							                      <span class="user-position"></span>
							                      <span class="record-date">`+replydate+`</span>
							                      <div class="js-remark-like comment-like">
							                          <span class="js-remark-like-button"><em class="txt-like">좋아요</em></span>
							                          <span class="js-remark-like-count comment-like-count">`+ reply1+`</span>
							                      </div>
							                  </div>
							                  <div class="comment-writer-menu">
							                      <button type="button" class="js-remark-update js-remark-edit-button comment-writer-button on">
							                          수정</button>
							                      <button type="button" class="js-remark-delete js-remark-edit-button comment-writer-button on">
							                          삭제</button>
							                  </div>
							                </div>
							              <div class="js-remark-layer comment-content">
							                  <div class="comment-text-area">
							                      <div class="js-remark-text comment-text"><div>`+replycontent+`</div></div>
							                  </div>
							              </div>
							          </div>
							      </li>										
				`;
				}			
				let process =hkbkbk1[a].process;
				let startdate = hkbkbk1[a].startdate;
				let deadline =  hkbkbk1[a].deadline;
				let priority = hkbkbk1[a].priority;
				let progress = hkbkbk1[a].progress;
				let manager = hkbkbk1[a].manager;
				let processing = "";
				if (process == "요청") {
				   processing = `<div class="js-task-state state-button-group clearfix request">`;
				}else if (process =="진행") {
					processing = `<div class="js-task-state state-button-group clearfix progress">`;
				}else if (process =="피드백") {
					processing = `<div class="js-task-state state-button-group clearfix feedback">`;
				}else if (process =="완료") {
					processing = `<div class="js-task-state state-button-group clearfix completion">`;
				}else if (process =="보류") {
					processing = `<div class="js-task-state state-button-group clearfix hold">`;
				}
				$("#projectFeedArea").append(
				'<div class="post-card-header immutable">  '
                +'   <div class="post-card-scroll"> '
                +'        <div class="card-header-top"> '
                +'            <div class="post-author main js-post-author" data-author-id="hkbk00@gmail.com"> '
                +'                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>  '
                +'                <dl class="post-author-info">  '
                +'                    <dt> '
                +'                        <strong class="author ellipsis notranslate">'+boardwriter+'</strong> '
                +'                        <em class="position ellipsis" style="display:inline" data="">'+jobtitle+'</em> '
                +'                        <span class="date">'+registdate+'</span> '
                +'                        <span class="post-security" style="display:inline" data=""> <i class="fa-solid fa-users" style="color:#aaa"></i></span> '
                +'                    </dt> '
                +'                    <dd class="d-block"> '
                +'                        <strong class=""></strong> '
                +'                        <span class="team"></span> '
                +'                    </dd> '
                +'                </dl> '
                +'            </div> '
                +'            <div> '
                +'                <div class="post-option"> '
                +'                    <button id="pinToTopBnt" class="js-pin-post fixed-btn js-pin-authority " style="display:block" data=""> '
                +'                        <span class="blind">상단 고정 등록</span> '
                +'                    </button> '
                +'                    <button class="js-setting-button set-btn"> '
                +'                        <span></span> '
                +'                        <span></span> '
                +'                        <span></span> '
                +'                    </button> '
                +'                    <ul class="js-setting-ul js-setting-layer setup-group d-none"> '
                +'                        <li class="js-setting-item" data-code="modify" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-write"></i>수정 '
                +'                                <i class="edit-auth-icon icons-question js-mouseover d-none" mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display:none" data=""></i> '
                +'                            </a> '
                +'                        </li> '
                +'                        <li class="js-setting-item" data-code="copy" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-project-1"></i>다른 프로젝트에 복사</a> '
                +'                        </li><li class="js-setting-item" data-code="url" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-copy"></i>링크 복사</a> '
                +'                        </li> '
                +'                        <li class="js-setting-item" data-code="delete" style="display:block" data=""> '
                +'                            <a href="#"> <i class="icons-delete-3"></i>삭제</a> '
                +'                        </li> '
                +'                    </ul> '
                +'                </div> '
                +'            </div> '
                +'        </div> '
                +'        <div class="card-header-bottom"> '
                +'            <div class="post-title-area"> '
                +'                <h4 class="post-title">'+title+'</h4> '
                +'            </div> '
                +'        </div> '
                +'        <div class="post-card-container"> '
				+'        <div id="originalPost" class="post-card-content " style="display:block" contenteditable="false"><div class="js-content-area create-content-area" style=""> '
				+'			<div class="js-upload-area js-paste-layer create-post-content" contenteditable="true" placeholder="내용을 입력하세요." spellcheck="false" ondrop="drop(event)" ondragover="allowDrop(event)"> '
				+'				'+content+'<div contenteditable="false" class=""></div> '
				+'			</div> '
				+'		<div class="js-task-option blockk" style="display: block;"> '
				+'			<ul class="create-content-group"> '
				+'				<li class="js-status-layer"> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="icon-post-status"></i> '
				+'					</div> '
				+'					<div class="create-content-cell"> '
				+ 							processing
				+'							<button type="button" class="task-state-button request" disabled="disabled">요청</button> '
				+'							<button type="button" class="task-state-button progress" disabled="disabled">진행</button> '
				+'							<button type="button" class="task-state-button feedback" disabled="disabled">피드백</button> ' 
				+'							<button type="button" class="task-state-button completion" disabled="disabled">완료</button> '
				+'							<button type="button" class="task-state-button hold" disabled="disabled">보류</button> '
				+'						</div> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-task-worker-layer js-more-task-li" style="display: flex" data=""> '
				+'					<div class="create-content-cell title manager"> '
				+'						<i class="icon-post-worker"></i> '
				+'					</div> '
				+'					<div class="create-content-cell manager-btn-group"> '
				+'						<div class="user-wrap"> '
				+'							<span class="js-workers manager-group"> '+manager+'</span> <input type="text" class="js-worker-input worker-search-input" placeholder="담당자 추가" style="display: none;" disabled="disabled"> '
				+'						</div> '
				+'						<button type="button" class="js-worker-button add-manager-button" style="display: none;" disabled="disabled">담당자 추가</button> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-date-layer js-start-date-layer js-more-task-li" style="display: flex;" data=""> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="fa-regular fa-calendar" style="color: #000000; font-size: 20px;"></i> '
				+'					</div> '
				+'					<div class="js-date-option create-content-cell"> '
				+'						<div class="js-pickr-layer js-start-flatpickr"> '
				+'							<label type="button" class="js-date-label add-manager-button" style="display: flex" disabled="disabled">  '
				+'								<input type="text" placeholder="시작일 추가" readonly="readonly" value='+startdate+' class="hasDatepicker" disabled="disabled"> '
				+'							</label> '
				+'						</div> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-date-layer js-end-date-layer js-more-task-li" style="display: flex;" data=""> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="fa-regular fa-calendar" style="color: #000000; font-size: 20px;"></i> '
				+'					</div> '
				+'					<div class="js-date-option create-content-cell"> '
				+'						<div class="js-pickr-layer js-end-flatpickr"> '
				+'							<label type="button" class="js-date-label add-manager-button" style="display: inline-block" disabled="disabled">  '
				+'								<input type="text" placeholder="마감일 추가" readonly="readonly" value="'+deadline+'" class="hasDatepicker" disabled="disabled"> '
				+'							</label> '
				+'						</div> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-priority-layer js-more-task-li" style="display: flex;" data=""> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="fa-regular fa-flag" style="color: #000000; font-size: 20px;"></i> '
				+'					</div> '
				+'					<div class="js-priority create-content-cell" data-priority=""> '
				+'						<button type="button" class="js-priority-button js-priority-event add-manager-button" style="display: inline-block; padding: 0;" data="" disabled="disabled"> '
				+'								'+priority+'</button> '
				+'						<div class="js-priority-span js-priority-event rank-item" style="display: none" data=""> '
				+'							<i class="icons- small"></i> <span class="js-priority-text"></span> '
				+'							<button type="button" class="js-remove-priority remove-button" disabled="disabled"></button> '
				+'						</div> '
				+'						<div class="js-priority-setting-layer js-priority-event priority-group main" style="display: none;"> '
				+'							<button type="button" class="js-priority-setting-button priority-button main" data-priority-code="low" disabled="disabled"> '
				+'								<span class=""> <i class="fa-solid fa-arrow-down" style="color: color: #777;"></i> '
				+'								</span>낮음 '
				+'							</button> '
				+'							<button type="button" class="js-priority-setting-button priority-button main" data-priority-code="normal" disabled="disabled"> '
				+'								<span class=""> <span style="width: 12px; font-weight: 800; color: #60c000;" class="">ㅡ</span> '
				+'								</span>보통 '
				+'							</button> '
				+'							<button type="button" class="js-priority-setting-button priority-button main" data-priority-code="high" disabled="disabled"> '
				+'								<span class=""> <i class="fa-solid fa-arrow-up" style="color: #ff7d04;"></i> '
				+'								</span>높음 '
				+'							</button> '
				+'							<button type="button" class="js-priority-setting-button priority-button main" data-priority-code="argent" disabled="disabled"> '
				+'								<span class=""> <i class="fa-solid fa-tower-broadcast" style="color: #ec1e1e;"></i> '
				+'								</span>긴급 '
				+'							</button> '
				+'						</div> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-section-layer" style="display: flex;" data-section-srno="0" data-section-uptask-yn="Y" data-section-list-cnt="101"> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="icon-section"></i> '
				+'					</div> '
				+'					<div class="js-section js-section-input section-search-input create-content-cell add-section-cell" data-section-srno="0" style="display: inline-block" data="">그룹 '
				+'						추가</div> '
				+'					<div class="js-section js-section-back-layer date-bg" style="display: none" data=""> '
				+'						<span class="js-section-text task-date">0</span> '
				+'						<button type="button" class="js-remove-section remove-button" style="display: inline-block" data="" disabled="disabled"></button> '
				+'					</div> '
				+'					<div class="js-section-popup js-section-select-layer section-select-popup js-grid-event all-seach-popup-type-2" style="display: none;" tabindex="0"> '
				+'						<div class="all-seach-section-wrap-3 scroll-mask"> '
				+'							<ul class=""></ul> '
				+'						</div> '
				+'					</div> '
				+'				</li> '
				+'				<li class="js-progress-layer js-more-task-li" style="display: flex;" data=""> '
				+'					<div class="create-content-cell title"> '
				+'						<i class="icon-post-progress"></i> '
				+'					</div> '
				+'					<div class="js-progress create-content-cell"> '
				+'						<div class="js-progress-bar progress-graph-bar" style="width: '+progress*1.3+'px;" =""="" data-progress="0"></div> '
				+'						<div class="progress-graph"> '
				+'							<span class="progress-button" data-progress-value="0" onclick="updateProgress(0)"><em style="display: none;" class="">0%</em></span> <span class="progress-button" data-progress-value="10" onclick="updateProgress(10)"><em style="display: none;" class="">10%</em></span> <span class="progress-button" data-progress-value="20" onclick="updateProgress(20)"><em style="display: none;" class="">20%</em></span> <span class="progress-button" data-progress-value="30" onclick="updateProgress(30)"><em style="display: none;" class="">30%</em></span> <span class="progress-button" data-progress-value="40" onclick="updateProgress(40)"><em style="display: none;" class="">40%</em></span> <span class="progress-button" data-progress-value="50" onclick="updateProgress(50)"><em style="display: none;" class="">50%</em></span> <span class="progress-button" data-progress-value="60" onclick="updateProgress(60)"><em style="display: none;" class="">60%</em></span> <span class="progress-button" data-progress-value="70" onclick="updateProgress(70)"><em style="display: block;" class="">'+progress+'%</em></span> <span class="progress-button" data-progress-value="80" onclick="updateProgress(80)"><em style="display: none;" class="">80%</em></span> <span class="progress-button" data-progress-value="90" onclick="updateProgress(90)"><em style="display: none;" class="">90%</em></span> <span class="progress-button" data-progress-value="100" onclick="updateProgress(100)"><em style="display: none;" class="">100%</em></span> '
				+'						</div> '
				+'						<span class="js-progress-text progress-txt">'+progress+'%</span> '
				+'					</div>  '
				+'				</li> '
				+'			</ul> '
				+'			<button type="button" class="js-more-button add-button" style="display: none;" data="" disabled="disabled"> '
				+'				<i class="fa-solid fa-plus" style="color: #555; margin-right: 10px;"></i>항목추가입력 '
				+'			</button> '
				+'		</div><div class="js-subtask-area subtask-wrap blockk" style="display: block;"> '
				+'				<div class="subtask-header"> '
				+'					<span class="subtask-title"> <img src="Images/icons8-folder-tree-64.png" style="width: 20px; margin-right: 10px;" class="">하위업무<em class="js-subtask-count subtask-count"></em> '
				+'					</span> '
				+'				</div> '
				+'				<div class="subtask-bottom js-subtask-edit-layer" style="display: block;"> '
				+'					<div class="subtask-registered-area js-subtask-edit-area"> '
				+'						<div class="subtask-input-area js-subtask-li" style="display: none;"> '
				+'							<div class="js-subtask-status-layer js-subtask-layer subtask-status-area"> '
				+'								<button type="button" class="js-subtask-status-button subtask-button subtask-status request" data_status="0" disabled="disabled">요청</button> '
				+'								<ul class="js-status-setting-layer js-subtask-layer subtask-status-list" style="display: none"> '
				+'									<li class=""> '
				+'										<div class="js-status-setting-button subtask-status request" data_status_code="0">요청</div> '
				+'									</li> '
				+'									<li class=""> '
				+'										<div class="js-status-setting-button subtask-status progress" data_status_code="1">진행</div> '
				+'									</li> '
				+'									<li class=""> '
				+'										<div class="js-status-setting-button subtask-status feedback" data_status_code="4">피드백</div> '
				+'									</li> '
				+'									<li class=""> '
				+'										<div class="js-status-setting-button subtask-status completion" data_status_code="2">완료</div> '
				+'									</li> '
				+'									<li class=""> '
				+'										<div class="js-status-setting-button subtask-status hold" data_status_code="3">보류</div> '
				+'									</li> '
				+'								</ul> '
				+'							</div> '
				+'							<input type="text" class="subtask-input js-subtask-input" tab-code="input" maxlength="100" data-empty-msg="하위 업무 제목을 입력하세요." data-required-yn="Y" placeholder="업무명 입력 (Enter로 업무 연속 등록 가능)" disabled="disabled"> '
				+'							<ul class="js-subtask-menu subtask-menu"> '
				+'								<li class="js-subtask-date-layer subtask-menu-date js-mouseover js-date-tooltip"> '
				+'									<span class="js-pickr-layer js-datepick-button subtask-button"> '
				+'									   <input type="hidden" class="flatpickr flatpickr-input" readonly="readonly" disabled="disabled"> '
				+'									     <span class="create-icon-box js-pickr-icon" onclick="showDatePicker1();"> '
				+'									       <i class="fa-regular fa-calendar"></i> '
				+'									      </span> '
				+'									     <input type="text" style="width: 90px !important; display:none;" readonly="" disabled="disabled" class=""> '
				+'									   </span> '
				+'									</li> '
				+'								<li class="js-subtask-priority-layer js-subtask-layer subtask-menu-priority js-mouseover clearfix" data_priority="" mouseover-text="우선순위 추가"> '
				+'									<button type="button" class="js-priority-button js-subtask-priority subtask-button create-icon-box small" disabled="disabled">	 '
				+'										<span class=""> <i class="fa-regular fa-flag" style="color: #000000; font-size: 20px;"></i> '
				+'										</span> '
				+'									</button> '
				+'								</li> '
				+'								<li class="subtask-menu-worker js-subtask-worker-layer js-mouseover" data_worker_id_list="" data_worker_name_list="" data_worker_profile_list="" mouseover-text="담당자 추가"> '
				+'									<button type="button" class="js-worker-button subtask-button manager js-worker-box create-icon-box small" tab-code="worker" disabled="disabled"> '
				+'										<span class=""> <i class="fa-regular fa-user"></i> '
				+'										</span> '
				+'									</button> '
				+'								</li> '
				+'							</ul> '
				+'							<button type="button" class="js-subtask-enter-button subtask-enter" disabled="disabled"> '
				+'								<i class="icons-reply"></i> '
				+'							</button> '
				+'							<button type="button" class="subtask-register-btn off" disabled="disabled"> '
				+'								<span class="blind">Register</span> '
				+'							</button> '
				+'							<div class="js-priority-setting-layer priority-group sub" style="display: none; top: -150px; left: 450px;"> '
				+'								<button type="button" class="js-priority-setting-button js-subtask-priority priority-button" data-key-index="0" data_priority_code="" disabled="disabled"> '
				+'									<span class=""> <span style=" color: #999;" class="">x</span> '
				+'									</span>취소 '
				+'								</button> '
				+'								<button type="button" class="js-priority-setting-button js-subtask-priority priority-button" data-key-index="1" data_priority_code="0" disabled="disabled"> '
				+'									<span class=""><i class="fa-solid fa-arrow-down" style="color: color: #777;"></i>	 '
				+'									</span>낮음 '
				+'								</button> '
				+'								<button type="button" class="js-priority-setting-button js-subtask-priority priority-button" data-key-index="2" data_priority_code="1" disabled="disabled"> '
				+'									<span class=""> <span style="width: 12px; font-weight: 800; color: #60c000;" class="">ㅡ</span> '
				+'									</span>보통 '
				+'								</button> '
				+'								<button type="button" class="js-priority-setting-button js-subtask-priority priority-button" data-key-index="3" data_priority_code="2" disabled="disabled"> '
				+'									<span class=""> <i class="fa-solid fa-arrow-up" style="color: #ff7d04;"></i> '
				+'									</span>높음 '
				+'								</button> '
				+'								<button type="button" class="js-priority-setting-button js-subtask-priority priority-button" data-key-index="4" data_priority_code="3" disabled="disabled"> '
				+'									<span class=""> <i class="fa-solid fa-tower-broadcast" style="color: #ec1e1e;"></i> '
				+'									</span>긴급 '
				+'								</button> '
				+'							</div> '
				+'						</div> '
				+'					</div> '
				+'				</div> '
				+'			</div></div></div> '
                +'            <div class="post-bottom-area"> '
                +'                <div class="post-bottom-menu js-reaction-bookmark"> '
                +'                    <div class="bottom-button-area"> '
                +'                        <button class="js-post-reaction post-bottom-button '+ like1+'"> '
                +'                            <i class="icon-reaction"></i> '
                +'                            <span>좋아요</span> '
                +'                        </button> '
                +'                        <button class="js-post-bookmark post-bottom-button "> '
                +'                            <i class="icon-bookmark"></i> '
                +'                            <span>북마크</span> '
                +'                        </button> '
                +'                    </div> '
                +'                </div> '
                +'                <div class="cmt-read-wr"> '
                +'                    <div class="comment-count-area"> '
                +'                        <span>댓글</span> '
                +'                        <span class="comment-count">0</span> '
                +'                    </div> '
                +'                    <div class="js-read-check-button read-confirmation" style="display:block" data=""> '
                +'                        <span>읽음</span> '
                +'                        <span class="confirmation-number">1</span> '
                +'                    </div> '
                +'                </div> '
                +'            </div> '
                +'        </div> '
                +'        <div class="post-card-footer"> '
                +'            <div class="comment-header"> '
                +'            </div> '
				+'				<ul class="post-comment-group"> '
				+				postCardFooter
				+'				</ul> '
                +'        </div> '
                +'        <div class="js-remark-layer js-edit-layer comment-input-wrap"> '
                +'            <div class="comment-thumbnail"> '
                +'                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span> '
                +'            </div> '
                +'            <form class="js-remark-form comment-container on " spellcheck="false"> '
                +'                <fieldset> '
                +'                    <legend class="blind">댓글 입력</legend> '
                +'                    <div class="js-remark-area js-paste-layer comment-input" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div> '
                +'                </fieldset> '
                +'            </form> '
                +'        </div> '
                +'    </div> '
                +' </div> '
				);
				a++;
                }
                if(type == 3){
                let title = hkbkbk[i].title1;
				let content = hkbkbk[i].content1;
				let boardwriter = hkbkbk[i].boardwriter1;
				let registdate = hkbkbk[i].registdate1;
				let jobtitle = hkbkbk[i].jobTitle;
				let replywriter = hkbkbk[i].replywriter;
				let replycontent = hkbkbk[i].replycontent;
				let replydate = hkbkbk[i].replydate;
				let like = hkbkbk[i].like;
				let replylike = hkbkbk[i].replylike;
				let like1 = "";
				let reply1 = "";
				let postCardFooter = '';
				 if (like) {
		            like1 = "on";
		        }
				if(replylike) {
						reply= "1";				
				}
				if(replywriter) {
					postCardFooter =`
									<li class="remark-item" remark-srno="70068272" data-user-id="a13sdf@naver.com">
							          <div class="comment-thumbnail js-comment-thumbnail">
							              <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
							          </div>
							          <div class="js-remark-view comment-container on ">
							              <div class="comment-user-area">
							                  <div class="comment-user">
							                      <span class="user-name js-comment-user-name notranslate">`+replywriter+`</span>
							                      <span class="user-position"></span>
							                      <span class="record-date">`+replydate+`</span>
							                      <div class="js-remark-like comment-like">
							                          <span class="js-remark-like-button"><em class="txt-like">좋아요</em></span>
							                          <span class="js-remark-like-count comment-like-count">`+ reply1+`</span>
							                      </div>
							                  </div>
							                  <div class="comment-writer-menu">
							                      <button type="button" class="js-remark-update js-remark-edit-button comment-writer-button on">
							                          수정</button>
							                      <button type="button" class="js-remark-delete js-remark-edit-button comment-writer-button on">
							                          삭제</button>
							                  </div>
							                </div>
							              <div class="js-remark-layer comment-content">
							                  <div class="comment-text-area">
							                      <div class="js-remark-text comment-text"><div>`+replycontent+`</div></div>
							                  </div>
							              </div>
							          </div>
							      </li>						
				`;
				}
				let startdate = hkbkbk2[b].startdate;
				let deadline = hkbkbk2[b].deadline;
				let lat = hkbkbk2[b].lat;
				let lng = hkbkbk2[b].lng;
				let alarm = hkbkbk2[b].Alarm;
				let join = hkbkbk2[b].joinId;
				let place = hkbkbk2[b].place;
				let address = hkbkbk2[b].address;
				console.log(address);
				console.log(lat);
				console.log(lng);
				let alarmtext = "";
				if(alarm == 1)
				alarmtext = "없음";
				else if(alarm == 2)
				alarmtext = "10분전 미리 알림";
				else if(alarm == 3)
				alarmtext = "30분전 미리 알림";
				else if(alarm == 4)
				alarmtext = "1시간 전 미리 알림";
				else if(alarm == 5)
				alarmtext = "2시간 전 미리 알림";
				else if(alarm == 6)
				alarmtext = "3시간 전 미리 알림";
				else if(alarm == 7)
				alarmtext = "1일전 미리 알림";
				else if(alarm == 8)
				alarmtext = "2일전 미리 알림";
				else if(alarm == 9)
				alarmtext = "7일전 미리 알림";
				$("#projectFeedArea").append(`
				<div class="post-card-header immutable">
                    <div class="post-card-scroll">
                        <div class="card-header-top">
                            <div class="post-author main js-post-author" data-author-id="hkbk00@gmail.com">
                                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
                                <dl class="post-author-info">
                                    <dt>
                                        <strong class="author ellipsis notranslate">`+boardwriter+`</strong>
                                        <em class="position ellipsis" style="display:inline" data="">`+jobtitle+`</em>
                                        <span class="date">`+registdate+`</span>
                                        <span class="post-security" style="display:inline" data=""> <i class="fa-solid fa-users" style="color:#aaa"></i></span>
                                    </dt>
                                    <dd class="d-block">
                                        <strong class=""></strong>
                                        <span class="team"></span>
                                    </dd>
                                </dl>
                            </div>
                            <div>
                                <div class="post-option">

                                    <button id="pinToTopBnt" class="js-pin-post fixed-btn js-pin-authority " style="display:block" data="">
                                        <!-- fixed-btn on class -->
                                        <span class="blind">상단 고정 등록</span>
                                    </button>
                                    <button class="js-setting-button set-btn">
                                        <span></span>
                                        <span></span>
                                        <span></span>
                                    </button>
                                    <ul class="js-setting-ul js-setting-layer setup-group d-none">
                                        <li class="js-setting-item" data-code="modify" style="display:block" data="">
                                            <a href="#"> <i class="icons-write"></i>수정
                                                <i class="edit-auth-icon icons-question js-mouseover d-none" mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display:none" data=""></i>
                                            </a>
                                        </li>
                                        <li class="js-setting-item" data-code="copy" style="display:block" data="">
                                            <a href="#"> <i class="icons-project-1"></i>다른 프로젝트에 복사</a>
                                        </li><li class="js-setting-item" data-code="url" style="display:block" data="">
                                            <a href="#"> <i class="icons-copy"></i>링크 복사</a>
                                        </li>
                                        
                                        <li class="js-setting-item" data-code="delete" style="display:block" data="">
                                            <a href="#"> <i class="icons-delete-3"></i>삭제</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </div>
                        <div class="card-header-bottom">
                            
                            <div class="post-title-area">
                                <h4 class="post-title">`+title +`</h4>
                            </div>
                        </div>
                        <div class="post-card-container">
				        <div id="originalPost" class="post-card-content " style="display:block" contenteditable="false"><div class="post-card-content js-schedule-comp blockk" style="" spellcheck="true">
							<ul class="create-content-group">
								<li class="schedule-date-li js-schedule-date-layer">
									<div class="create-content-cell title">
										<i class="fa-regular fa-calendar" style="font-size: 18px;color: #000;margin-right: 6px;"></i>
									</div>
									<div class="create-content-cell">
										<div class="schedule-time">
											<div class="js-pickr-layer js-start-flatpickr">
													<input class="js-pickr-text schedule-input hasDatepicker" value="`+startdate+`" type="text" readonly="" disabled="disabled">
											</div>
											<div class="js-pickr-layer js-end-flatpickr">
												<input class="js-pickr-text schedule-input hasDatepicker" value="`+deadline+`" type="text" readonly="" disabled="disabled">
											</div>
										</div>
									</div>
								</li>
								<li class="js-attendance-layer">
									    <div class="create-content-cell title manager">
									        <i class="icon-post-worker"></i>
									    </div>
									    <div class="create-content-cell manager-btn-group">
									        <div class="user-wrap">
									            <span class="js-manager-group manager-group"> 
									            `+ join +`</span> 
									        </div>
									    </div>
									</li>
								<li class="">
									<div class="create-content-cell title">
										<i class="icon-post-alarm"></i>
									</div>
									<div class="create-content-cell">
										<span class="alarm-text">`+alarmtext +`</span> 
									</div>
								</li>
										<div class="js-content-area create-content-area">
									
											<div class="js-upload-area js-paste-layer create-post-content" contenteditable="true" placeholder="내용을 입력하세요." spellcheck="false" ondrop="drop(event)" ondragover="allowDrop(event)" style="padding: 0;">
											`+content+`<div contenteditable="false" class=""><div style="width:585px; height:340px; border: 1px solid black; display: inline-block;" class=""><img src="https://maps.googleapis.com/maps/api/staticmap?center=`+lat+`,`+lng+`&amp;zoom=14&amp;size=580x240&amp;maptype=roadmap&amp;markers=color:blue%7C`+lat+`,`+lng+`&amp;key=AIzaSyAGqbkrXZ42f8TtH3Sv6Uu4edzDm3EvCoM" alt="지도 이미지" class=""><h4 style="margin:0;" class="">`+place +`</h4><p style="margin:0;" class="">`+ address +`</p></div></div>
										</div>
									</div>
							</ul>
						</div></div>
                            <div class="post-bottom-area">
                                <div class="post-bottom-menu js-reaction-bookmark">
                                    <div class="bottom-button-area">
                                        <button class="js-post-reaction post-bottom-button `+ like1+`">
                                            <i class="icon-reaction"></i>
                                            <span>좋아요</span>
                                        </button>
                                        <button class="js-post-bookmark post-bottom-button ">
                                            <i class="icon-bookmark"></i>
                                            <span>북마크</span>
                                        </button>
                                    </div>
                                </div>
                                <div class="cmt-read-wr">
                                    <div class="comment-count-area">
                                        <span>댓글</span>
                                        <span class="comment-count">0</span>
                                    </div>
                                    <div class="js-read-check-button read-confirmation" style="display:block" data="">
                                        <span>읽음</span>
                                        <span class="confirmation-number">1</span>
                                    </div>
                                </div>

                            </div>
                            <!-- //post-card-container -->
                        </div>
                        <div class="post-card-footer">
                            <div class="comment-header">
                            </div>
								<ul class="post-comment-group">
								`+postCardFooter+`
								</ul>
                        </div>
                        <div class="js-remark-layer js-edit-layer comment-input-wrap">
                            <div class="comment-thumbnail">
                                <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
                            </div>
                            <form class="js-remark-form comment-container on " spellcheck="false">
                                <fieldset>
                                    <legend class="blind">댓글 입력</legend>
                                    <div class="js-remark-area js-paste-layer comment-input" contenteditable="true" placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
                                </fieldset>
                            </form>
                        </div>
                    </div>
                </div>`
					)
					b++;
                }
                if(type == 4){
				let title = hkbkbk[i].title1;
				let boardwriter = hkbkbk[i].boardwriter1;
				let registdate = hkbkbk[i].registdate1;
				let jobtitle = hkbkbk[i].jobTitle;
				let replywriter = hkbkbk[i].replywriter;
				let replycontent = hkbkbk[i].replycontent;
				let replydate = hkbkbk[i].replydate;
				let like = hkbkbk[i].like;
				let replylike = hkbkbk[i].replylike;
				let like1 = "";
				let reply1 = "";
				let postCardFooter = '';
				 if (like) {
		            like1 = "on";
		        }
				if(replylike) {
						reply= "1";				
				}
				if(replywriter) {
					postCardFooter =`
									<li class="remark-item" remark-srno="70068272" data-user-id="a13sdf@naver.com">
							          <div class="comment-thumbnail js-comment-thumbnail">
							              <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
							          </div>
							          <div class="js-remark-view comment-container on ">
							              <div class="comment-user-area">
							                  <div class="comment-user">
							                      <span class="user-name js-comment-user-name notranslate">`+replywriter+`</span>
							                      <span class="user-position"></span>
							                      <span class="record-date">`+replydate+`</span>
							                      <div class="js-remark-like comment-like">
							                          <span class="js-remark-like-button"><em class="txt-like">좋아요</em></span>
							                          <span class="js-remark-like-count comment-like-count">`+ reply1+`</span>
							                      </div>
							                  </div>
							                  <div class="comment-writer-menu">
							                      <button type="button" class="js-remark-update js-remark-edit-button comment-writer-button on">
							                          수정</button>
							                      <button type="button" class="js-remark-delete js-remark-edit-button comment-writer-button on">
							                          삭제</button>
							                  </div>
							                </div>
							              <div class="js-remark-layer comment-content">
							                  <div class="comment-text-area">
							                      <div class="js-remark-text comment-text"><div>`+replycontent+`</div></div>
							                  </div>
							              </div>
							          </div>
							      </li>						
				`;
				}
				let content = hkbkbk3[c].content;
				let manager = hkbkbk3[c].manager;
				let deadline = hkbkbk3[c].deadline;
				$("#projectFeedArea").append(`
					<div class="post-card-header immutable">
						<div class="post-card-scroll">
							<div class="card-header-top">
								<div class="post-author main js-post-author"
									data-author-id="hkbk00@gmail.com">
									<span class="thumbnail size40 radius16"
										style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
										data=""></span>
									<dl class="post-author-info">
										<dt>
											<strong class="author ellipsis notranslate">`+boardwriter+`</strong> <em
												class="position ellipsis" style="display: inline" data="">`+jobtitle+`</em>
											<span class="date">`+registdate+`</span> <span
												class="post-security" style="display: inline" data=""> <i
												class="fa-solid fa-users" style="color: #aaa"></i></span>
										</dt>
										<dd class="d-block">
											<strong class=""></strong> <span class="team"></span>
										</dd>
									</dl>
								</div>
								<div>
									<div class="post-option">
										<button id="pinToTopBnt"
											class="js-pin-post fixed-btn js-pin-authority "
											style="display: block" data="">
											<span class="blind">상단 고정 등록</span>
										</button>
										<button class="js-setting-button set-btn">
											<span></span> <span></span> <span></span>
										</button>
										<ul class="js-setting-ul js-setting-layer setup-group d-none">
											<li class="js-setting-item" data-code="modify"
												style="display: block" data=""><a href="#"> <i
													class="icons-write"></i>수정 <i
													class="edit-auth-icon icons-question js-mouseover d-none"
													mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display: none"
													data=""></i>
											</a></li>
											<li class="js-setting-item" data-code="copy"
												style="display: block" data=""><a href="#"> <i
													class="icons-project-1"></i>다른 프로젝트에 복사
											</a></li>
											<li class="js-setting-item" data-code="url" style="display: block"
												data=""><a href="#"> <i class="icons-copy"></i>링크 복사
											</a></li>
											<li class="js-setting-item" data-code="delete"
												style="display: block" data=""><a href="#"> <i
													class="icons-delete-3"></i>삭제
											</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="card-header-bottom">
								<div class="post-title-area">
									<h4 class="post-title">`+title+`</h4>
								</div>
							</div>
							<div class="post-card-container">
								<div id="originalPost" class="post-card-content "
									style="display: block" contenteditable="false">
									<div class="postCntn3 blockk" style="">
										<ul class="todo-group">
											<div class="subtask-input-area todo-area clone">
												<input type="text" class="js-todo-content-input"
													placeholder="할 일 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off"
													maxlength="60" data-empty-msg="할 일을 입력하세요" data-required-yn="Y"
													data-over-msg="60자를 초과할 수 없습니다." style="border: none;"
													value="`+content+`" disabled="disabled">
												<div class="todo-menu">
													<span class="js-pickr-layer subtask-button"> <input
														type="text" class="selectedDate" onclick="showDatePicker();"
														style="width: 90px !important;" value="`+deadline+`";display: inherit;" readonly=""
														disabled="disabled">
													</span>
													<button type="button" class="js-worker-button subtask-button"
														disabled="disabled">
														<span class="create-icon-box"><i
															class="icon-post-worker"></i></span>
													</button>
												</div>
											</div>
										</ul>
									</div>
								</div>
								<div class="post-bottom-area">
									<div class="post-bottom-menu js-reaction-bookmark">
										<div class="bottom-button-area">
											<button class="js-post-reaction post-bottom-button `+ like1+`">
												<i class="icon-reaction"></i> <span>좋아요</span>
											</button>
											<button class="js-post-bookmark post-bottom-button ">
												<i class="icon-bookmark"></i> <span>북마크</span>
											</button>
										</div>
									</div>
									<div class="cmt-read-wr">
										<div class="comment-count-area">
											<span>댓글</span> <span class="comment-count">0</span>
										</div>
										<div class="js-read-check-button read-confirmation"
											style="display: block" data="">
											<span>읽음</span> <span class="confirmation-number">1</span>
										</div>
									</div>
								</div>
							</div>
							<div class="post-card-footer">
								<div class="comment-header"></div>
								<ul class="post-comment-group">
								`+postCardFooter+`
								</ul>
							</div>
							<div class="js-remark-layer js-edit-layer comment-input-wrap">
								<div class="comment-thumbnail">
									<span class="thumbnail size40 radius16"
										style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
										data=""></span>
								</div>
								<form class="js-remark-form comment-container on " spellcheck="false">
									<fieldset>
										<legend class="blind">댓글 입력</legend>
										<div class="js-remark-area js-paste-layer comment-input"
											contenteditable="true"
											placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				`)
				c++;
                }
                if(type == 5){
                let title = hkbkbk[i].title1;
				let content = hkbkbk[i].content1;
				let boardwriter = hkbkbk[i].boardwriter1;
				let registdate = hkbkbk[i].registdate1;
				let jobtitle = hkbkbk[i].jobTitle;
				let replywriter = hkbkbk[i].replywriter;
				let replycontent = hkbkbk[i].replycontent;
				let replydate = hkbkbk[i].replydate;
				let like = hkbkbk[i].like;
				let replylike = hkbkbk[i].replylike;
				let like1 = "";
				let reply1 = "";
				let postCardFooter = '';
				 if (like) {
		            like1 = "on";
		        }
				if(replylike) {
						reply= "1";				
				}
				if(replywriter) {
					postCardFooter =`
								<ul class="post-comment-group">
									<li class="remark-item" remark-srno="70068272" data-user-id="a13sdf@naver.com">
							          <div class="comment-thumbnail js-comment-thumbnail">
							              <span class="thumbnail size40 radius16" style="background-image: url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202307201119753_c0de729a-4cb2-4b52-8831-fb95f59540b3.jpg), url(/flow-renewal/assets/images/profile-default.svg)" data=""></span>
							          </div>
							          <div class="js-remark-view comment-container on ">
							              <div class="comment-user-area">
							                  <div class="comment-user">
							                      <span class="user-name js-comment-user-name notranslate">`+replywriter+`</span>
							                      <span class="user-position"></span>
							                      <span class="record-date">`+replydate+`</span>
							                      <div class="js-remark-like comment-like">
							                          <span class="js-remark-like-button"><em class="txt-like">좋아요</em></span>
							                          <span class="js-remark-like-count comment-like-count">`+ reply1+`</span>
							                      </div>
							                  </div>
							                  <div class="comment-writer-menu">
							                      <button type="button" class="js-remark-update js-remark-edit-button comment-writer-button on">
							                          수정</button>
							                      <button type="button" class="js-remark-delete js-remark-edit-button comment-writer-button on">
							                          삭제</button>
							                  </div>
							                </div>
							              <div class="js-remark-layer comment-content">
							                  <div class="comment-text-area">
							                      <div class="js-remark-text comment-text"><div>`+replycontent+`</div></div>
							                  </div>
							              </div>
							          </div>
							      </li>						
								</ul>					
				`;
				}
				let deadline = hkbkbk4[d].deadline;
				let revenge =hkbkbk4[d].revenge_vote;
				let anonymous = hkbkbk4[d].anonymous_vote;
				let anyone = hkbkbk4[d].anyone_add;
				let hidden = hkbkbk4[d].hidden_poll;
				let result = hkbkbk4[d].result_time;
				let revenge1 = "";
				if(revenge == 1){
					revenge1 ="active";
				}
				let anonymous1 = "";
				if(anonymous == 1){
					anonymous1 ="active";
				}
				let anyone1 = "";
				if(anyone == 1){
					anyone1 = "active";
				}
				let hidden1 = "";
				if(hidden == 1){
					hidden1 = "active";
				}
				let result1 = "실시간";
				if(result == 1){
					result = "투표 종료후";
				}
				    const voteList = $("#projectFeedArea .vote-option-input-area").last();
					const contents = hkbkbk4[d].contents;
					
					for (let i = 0; i < contents.length; i++) {
				if (!contents[i] || contents[i].trim() === "") continue;
					  const voteInputArea = `
					    <div class="vote-input-area">
					      <p class="">
					        <input type="text" class="vote-option-input-text" placeholder="항목 추가 (Enter 또는 Tab) / 최대 60자" autocomplete="off" maxlength="60" value="${contents[i]}" disabled="disabled">
					      </p>
					    </div>
					  `;
					  voteList.prepend(voteInputArea);
					}
				  if (titleIds.has(title)) continue; // 이미 처리된 제목은 건너뜁니다.
				  titleIds.add(title);
				$("#projectFeedArea").append(`
					<div class="post-card-header immutable">
						<div class="post-card-scroll">
							<div class="card-header-top">
								<div class="post-author main js-post-author"
									data-author-id="hkbk00@gmail.com">
									<span class="thumbnail size40 radius16"
										style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
										data=""></span>
									<dl class="post-author-info">
										<dt>
											<strong class="author ellipsis notranslate">`+boardwriter+`</strong> <em
												class="position ellipsis" style="display: inline" data="">`+jobtitle+`</em>
											<span class="date">`+registdate+`</span> <span
												class="post-security" style="display: inline" data=""> <i
												class="fa-solid fa-users" style="color: #aaa"></i></span>
										</dt>
										<dd class="d-block">
											<strong class=""></strong> <span class="team"></span>
										</dd>
									</dl>
								</div>
								<div>
									<div class="post-option">
										<button id="pinToTopBnt"
											class="js-pin-post fixed-btn js-pin-authority "
											style="display: block" data="">
											<span class="blind">상단 고정 등록</span>
										</button>
										<button class="js-setting-button set-btn">
											<span></span> <span></span> <span></span>
										</button>
										<ul class="js-setting-ul js-setting-layer setup-group d-none">
											<li class="js-setting-item" data-code="modify"
												style="display: block" data=""><a href="#"> <i
													class="icons-write"></i>수정 <i
													class="edit-auth-icon icons-question js-mouseover d-none"
													mouseover-text="공동 수정 권한이 활성화 되어있습니다." style="display: none"
													data=""></i>
											</a></li>
											<li class="js-setting-item" data-code="copy"
												style="display: block" data=""><a href="#"> <i
													class="icons-project-1"></i>다른 프로젝트에 복사
											</a></li>
											<li class="js-setting-item" data-code="url" style="display: block"
												data=""><a href="#"> <i class="icons-copy"></i>링크 복사
											</a></li>
											<li class="js-setting-item" data-code="delete"
												style="display: block" data=""><a href="#"> <i
													class="icons-delete-3"></i>삭제
											</a></li>
										</ul>
									</div>
								</div>
							</div>
							<div class="card-header-bottom">
								<div class="post-title-area">
									<h4 class="post-title">`+title+`</h4>
								</div>
							</div>
							<div class="post-card-container">
								<div id="originalPost" class="post-card-content "
									style="display: block" contenteditable="false">
									<div class="postCntn4 create-content-area blockk" style="">
										<div class="vote-post-content" contenteditable="true"
											 spellcheck="false">`+content+`</div>
										<div class="vote-area">
											<div class="vote-list">
												<div class="vote-option-input-area">
												</div>
											</div>
										</div>
										<div class="vote-option-container">
											<ul class="vote-option-wrap">
												<li class="vote-deadline">
													<div class="vote-option-text">
														<i class="fa-solid fa-clock-rotate-left"></i> <span class="">투표
															마감일</span>
													</div>
													<div class="vote-date-wrap">
														<input value="`+deadline+`" type="text" class="hasDatepicker"
															disabled="disabled">
													</div>
												</li>
												<li class="vote-multiple">
													<div class="vote-option-text">
														<i class="fa-solid fa-check-double"></i> <span class="">복수
															투표</span>
													</div>
													<button type="button" class="vote-option toggle-button `+revenge1+`"
														disabled="disabled">
														<i class="handle"></i>
													</button>
												</li>
												<li class="vote-anonymous">
													<div class="vote-option-text">
														<i class="fa-solid fa-question"></i> <span class="">익명
															투표</span>
													</div>
													<button type="button" class="vote-option toggle-button `+anonymous1+`"
														disabled="disabled">
														<i class="handle"></i>
													</button>
												</li>
												<li class="vote-anyone">
													<div class="vote-option-text">
														<i class="fa-solid fa-user-plus"></i> <span class="">투표
															중 누구나 항목 추가 가능</span>
													</div>
													<button type="button" class="vote-option toggle-button `+anyone1+`"
														disabled="disabled">
														<i class="handle"></i>
													</button>
												</li>
												<li class="vote-private">
													<div class="vote-option-text">
														<i class="fa-solid fa-lock"></i> <span class="">투표 결과 나만
															보기</span>
													</div>
													<button type="button" class="vote-option toggle-button `+hidden1+`"
														disabled="disabled">
														<i class="handle"></i>
													</button>
												</li>
												<li class="vote-opentype">
													<div class="vote-option-text">
														<i class="fa-solid fa-volume-high"></i> <span class="">투표
															결과 공개 시점</span>
													</div>
													<div class="vote-check">
													  <input type="text" /> `+result1+`
													</div>
												</li>
											</ul>
										</div>
									</div>
								</div>
								<div class="post-bottom-area">
									<div class="post-bottom-menu js-reaction-bookmark">
										<div class="bottom-button-area">
											<button class="js-post-reaction post-bottom-button `+ like1+`">
												<i class="icon-reaction"></i> <span>좋아요</span>
											</button>
											<button class="js-post-bookmark post-bottom-button ">
												<i class="icon-bookmark"></i> <span>북마크</span>
											</button>
										</div>
									</div>
									<div class="cmt-read-wr">
										<div class="comment-count-area">
											<span>댓글</span> <span class="comment-count">0</span>
										</div>
										<div class="js-read-check-button read-confirmation"
											style="display: block" data="">
											<span>읽음</span> <span class="confirmation-number">1</span>
										</div>
									</div>
								</div>
							</div>
							<div class="post-card-footer">
								<div class="comment-header"></div>
								<ul class="post-comment-group">
								`+postCardFooter+`
								</ul>
							</div>
							<div class="js-remark-layer js-edit-layer comment-input-wrap">
								<div class="comment-thumbnail">
									<span class="thumbnail size40 radius16"
										style="background-image: url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png?width=400&amp;height=400), url(https://flow.team/flowImg/FLOW_202306151753937_52d2d9aa-b7a4-42ea-8a2a-b67fbb46c7b0.png), url(/flow-renewal/assets/images/profile-default.svg)"
										data=""></span>
								</div>
								<form class="js-remark-form comment-container on " spellcheck="false">
									<fieldset>
										<legend class="blind">댓글 입력</legend>
										<div class="js-remark-area js-paste-layer comment-input"
											contenteditable="true"
											placeholder="줄바꿈 Shift + Enter / 입력 Enter 입니다."></div>
									</fieldset>
								</form>
							</div>
						</div>
					</div>
				`)
				d++;
                }
            }
        },      
    });
}


function load_project(){
	$.ajax({
		url:"ProjectServlet1",
		type:"POST",
		data:{
			send_id:nowId
		},
		success: function(abc){
			var data1 = abc;
			console.log(data1);
			let count = 0;
			for(let i=0;i<data1.length;i++){
				let title = data1[i].title;
				let id = data1[i].id;
				let color = data1[i].color;
				$("#RecentProjectUl").append(`
				<li class="recent-project-item" data-project-srno="`+id+`" data-color-code="4" home-tab="FEED">
					<div class="squre-type color-code-`+color+` new">
						<div class=""></div>
							</div> <span class="js-mouseover ellipsis">`+title+`</span>
				</li>  `
				);
				count++;
				if(count== 5)
				break;
			}
		}		
	});
};

function load_member(project_id){
	$.ajax({
		url:"MemberServlet",
		type:"POST",
		data:{
			send_projectId : project_id
		},
		success: function(abc){
			var data1 = abc;
			console.log(data1);
			for(let i=0;i<data1.length;i++){
				let name = data1[i].name;
				let title = data1[i].title;
				let company = data1[i].company;
				$("#participantsUl").append(`
				<li class="js-participant-item" style="display: flex;">
					<div class="post-author">
						<span class="js-participant-profile thumbnail size40 radius16" style="background-image: url(https://flow.team/flow-renewal/assets/images/profile-default.png), url(https://flow.team/flow-renewal/assets/images/profile-default.png), url(https://flow.team/flow-renewal/assets/images/profile-default.png)" data=""></span>
							<dl class="post-author-info">
								<dt>
									<strong class="js-participant-name author ellipsis">`+ name +`</strong>
									<em class="position ellipsis" style="display: flex">`+title+`</em>
								</dt>
									<dd style="display: flex">
										<strong class="company">`+company+`</strong> 
									</dd>
							</dl>
						</div>
				</li>`
				);
			}
			$("#participantCount").text(data1.length);
		}		
	});
};

$(function() {
    $(document).on('click', '.js-post-reaction.post-bottom-button', function() {
        $(this).toggleClass('on');
    });
});
$(function(){
     $(document).on('click','.js-post-bookmark.post-bottom-button',function() {
    	 $(this).toggleClass('on');
    	});
     });
   	 $(function () {
   		$("#RecentProjectUl").on("click", ".recent-project-item", function () {
   		 const project_id = $(this).attr("data-project-srno");
		 const project_title = $(this).find(".js-mouseover").text(); // 프로젝트 이름 가져오기
		 const project_color = $(this).find(".squre-type").attr("class").match(/color-code-\d+/)[0]; // 색상 코드 가져오기
   		$("#projectTitle").text(project_title);
		$("#projectTitle").attr("project_id",project_id);
		$("#projectColor").attr("class", "project-color " + project_color); 
   		 $("#projectFeedArea").empty();
   		 $("#participantsUl").empty();
   			load_board(project_id);
			load_member(project_id);
   		});
   	 });


function create_post(project_id,title,startdate,deadline,attendance,lat,lng,placeName,address,value){
    $.ajax({
        url:"CreateServlet",
        type:"POST",
        data:{
            projectId : project_id,
			title : title,
			startdate : startdate,
			deadline : deadline,
			attendance: attendance,
			lat: lat,
			lng : lng,
			placeName : placeName,
			address : address,
			value : value, 
			nowId : nowId
        }
	});
}