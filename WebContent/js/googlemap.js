  function initAutocomplete() {
    let searchBox = new google.maps.places.SearchBox(document.getElementById("search-box"));
  }
  function initAutocomplete1() {
    let searchBox = new google.maps.places.SearchBox(document.getElementById("search-box1"));
  }
function setBackgroundColor(container, color) {
    container.style.backgroundColor = color;
  }

  function setLocalMessage(container, lat, lon) {
    container.innerText = "Latitude: " + lat + ", Longitude: " + lon;
  }

  function createMiniMap(map_div, lat, lon) {
    var miniMap = new google.maps.Map(map_div, {
      center: { lat: lat, lng: lon },
      zoom: 15,
    });

    var marker = new google.maps.Marker({
      position: { lat: lat, lng: lon },
      map: miniMap,
    });
  }
	function allowDrop(ev) {
		  ev.preventDefault();
		}

		function drop(ev) {
		  ev.preventDefault();

		  let file = ev.dataTransfer.files[0];
		  let reader = new FileReader();

		  reader.onload = function (event) {
		    let newImageDiv = document.createElement("div");
		    newImageDiv.className = "upload-img-area full-area";

		    let newImage = document.createElement("img");
		    newImage.className = "upload-img";

		    // 이미지를 Blob으로 변환하고 URL 생성
		    fetch(event.target.result)
		      .then((response) => response.blob())
		      .then((blob) => {
		        newImage.src = URL.createObjectURL(blob);
		        newImage.onerror = function () {
		          this.src = "/flow-renewal/assets/images/no_photo.jpg";
		        };

		        newImageDiv.appendChild(newImage);
		        let dropzone = document.querySelector(".js-upload-area");
		        dropzone.insertAdjacentElement("beforeend", newImageDiv);
		      });
		  };

		  reader.readAsDataURL(file);
		}
    
    
     document.addEventListener("DOMContentLoaded", function () {
         const taskStateElement = document.querySelector(".js-task-state");
         const taskStateButtons1 = taskStateElement.querySelector(".task-state-button.request");
         const taskStateButtons2 = taskStateElement.querySelector(".task-state-button.progress");
         const taskStateButtons3 = taskStateElement.querySelector(".task-state-button.feedback");
         const taskStateButtons4 = taskStateElement.querySelector(".task-state-button.completion");
         const taskStateButtons5 = taskStateElement.querySelector(".task-state-button.hold");
	        
         const stateClasses = ['request', 'progress', 'feedback', 'completion', 'hold'];

         taskStateButtons1.onclick = () => {
             stateClasses.forEach(state => taskStateElement.classList.remove(state));
             taskStateElement.classList.add('request');
         };

         taskStateButtons2.onclick = () => {
             stateClasses.forEach(state => taskStateElement.classList.remove(state));
             taskStateElement.classList.add('progress');
         };

         taskStateButtons3.onclick = () => {
             stateClasses.forEach(state => taskStateElement.classList.remove(state));
             taskStateElement.classList.add('feedback');
         };

         taskStateButtons4.onclick = () => {
             stateClasses.forEach(state => taskStateElement.classList.remove(state));
             taskStateElement.classList.add('completion');
         };

         taskStateButtons5.onclick = () => {
             stateClasses.forEach(state => taskStateElement.classList.remove(state));
             taskStateElement.classList.add('hold');
         };
     });
     
     function displayFlexOnElementsByClassName(className) {
         const elements = document.getElementsByClassName(className);
         for (const element of elements) {
             if (element.style.display !== 'flex') {
                 element.style.display = 'flex';
             }
         }
     }

     function init() {
         const moreButton = document.querySelector('.js-more-button.add-button');
         if (moreButton) {
             moreButton.addEventListener('click', () => {
                 displayFlexOnElementsByClassName('js-date-layer');
                 displayFlexOnElementsByClassName('js-priority-layer');
                 displayFlexOnElementsByClassName('js-section-layer');
                 displayFlexOnElementsByClassName('js-progress-layer');
                 document.querySelector('.js-more-button.add-button').style.display ='none';
             });
         } 
     }

     document.addEventListener('DOMContentLoaded', init);
     
     $(document).ready(function () {
    	  // js-map-button 클릭 시
    	  $(".js-map-button").on("click", function (event) {
    	    // 메뉴가 열릴 때 기본 이벤트 동작 중지
    	    event.stopPropagation();
    	    // upload-menu map-search 엘리먼트의 display 속성을 block으로 변경
    	    $(".upload-menu.map-search").css("display", "block");
    	  });

    	  // 문서 전체를 대상으로 누르지 않은 경우 작동
    	  $(document).on("mousedown", function () {
    	    // upload-menu map-search 엘리먼트의 display 속성을 none으로 변경
    	    $(".upload-menu.map-search").css("display", "none");
    	  });

    	  // 각 지역 클릭 시 이벤트 전달 중지
    	  $(".upload-menu.map-search").on("mousedown", function (event) {
    	    event.stopPropagation();
    	  });
    	});
     
     $(document).ready(function () {
   	  $(".js-add-subtask-button").on("click", function (event) {
   		  $(".subtask-input-area.js-subtask-li").css("display","flex");
   		  $(".js-add-subtask-button").css("display","none");
   	  });
   	});
     $(document).ready(function () {
   	  $("#priorityButton").on("click", function (event) {
   		  $(".js-priority-event.priority-group").toggle();
   	  });
   	});
     $(document).ready(function () {
     $('.js-priority-button.js-subtask-priority.subtask-button.create-icon-box.small').on('click', function () {
		    $('.priority-group.sub').toggle();
		  });
     });
     $(document).ready(function(){
    $('#createPostArea').on('click',function() {
     $('.flow-all-background-1.js-popup-before').removeClass('d-none');
     $('.flow-all-background-1.js-popup-before').addClass('d-block');
    	});
     });
     
     $(document).ready(function(){
     		 $('#taskReportToggleButton').on('click',function() {
    	  $('.js-task-report-layer').toggle();
    	});
     });
     
     document.addEventListener("DOMContentLoaded", function () {
    	    var tabItems = document.getElementsByClassName("js-tab-item");

    	    for (var i = 0; i < tabItems.length; i++) {
    	        (function (index) {
    	            tabItems[index].addEventListener("click", function () {
    	                for (var j = 0; j < tabItems.length; j++) {
    	                    if (tabItems[j].classList.contains("active")) {
    	                        tabItems[j].classList.remove("active");
    	                    }
    	                }
    	                tabItems[index].classList.add("active");
    	            });
    	        })(i);
    	    }
    	});
     $(document).ready(function(){
 		 $('#searchResultClose').on('click',function() {
	  $('.search-container').css("display","none");
	});
 });
     
     function hideAllSearchAreas() {
    	    document.getElementById('projectSearchArea').style.display = 'none';
    	    document.getElementById('postSearchArea').style.display = 'none';
    	}

    	document.addEventListener('DOMContentLoaded', function () {
    	    var tabItems = document.getElementsByClassName('js-tab-item');

    	    function handleClick(tabItem) {
    	        for (var i = 0; i < tabItems.length; i++) {
    	            tabItems[i].classList.remove('active');
    	        }

    	        tabItem.classList.add('active');
    	        var dataCode = tabItem.getAttribute('data-code');
    	        hideAllSearchAreas();
    	        
    	        if (dataCode === 'total') {
    	            document.getElementById('projectSearchArea').style.display = 'block';
    	            document.getElementById('postSearchArea').style.display = 'block';
    	            document.getElementById('searchEventArea').classList.add('total');
    	        } else if (dataCode === 'project') {
    	            document.getElementById('projectSearchArea').style.display = 'block';
    	            document.getElementById('searchEventArea').classList.remove('total');
    	        } else if (dataCode === 'post') {
    	            document.getElementById('postSearchArea').style.display = 'block';
    	            document.getElementById('searchEventArea').classList.remove('total');
    	        } 
    	    }

    	    for (var i = 0; i < tabItems.length; i++) {
    	        tabItems[i].addEventListener('click', function (event) {
    	            handleClick(event.currentTarget);
    	        });
    	    }

    	});
    	$(function () {
    		  $(".js-filter-search.condition-button.search").click(function () {
    		    $("#topSettingBar").css('display','none');
    		    $("#mainContent").css('display','none');
    		    $(".search-container").css('display','block');

    		    // Reset the 'active' class on all tab items
    		    $("li.js-tab-item").removeClass("active");

    		    // Check if #detailSearchArea is visible
    		    if ($(".js-participant-name-search-filter").is(":visible")) {
    		      // If it is visible, set the 'project' tab to 'active'
    		      $("li.js-tab-item[data-code='project']").addClass("active");
    		    } else {
    		      // If it's not visible, set the 'post' tab to 'active' instead
    		      $("li.js-tab-item[data-code='post']").addClass("active");
    		    }
    		    let searchInput = $("#searchPopupInput").val();
    		    load_list(searchInput,nowId);
    		  });
    		});
   
   	 $(function () {
   		$("#searchResultClose").click(function() {
   			$("#topSettingBar").css('display','block');
		    $("#mainContent").css('display','block');
		    $(".search-container").css('display','none');
   		});
   	 });
   	 
window.onload = function() {
  load_project();
}


$(function(){
	  let selectedValue;
	$("#alarmButton").change(function() {
    // 선택된 옵션의 텍스트 값을 가져옵니다.
    const selectedText = $(this).find("option:selected").text();
    selectedValue = this.value;
    console.log("Selected value:", selectedValue);

    // #alarmSpan 요소의 텍스트를 변경합니다.
    $("#alarmSpan").text(selectedText);
  });

	$(".create-post-submit").click(function(){
		let project_id = $("#projectTitle").attr("project_id");
		let title2 = $("#postTitle").val();
		let startdate = $("#pick1").val();
		let deadline = $("#pick2").val();
		let attendance = $(".js-registration.manager-item").text();
		  let mapImage = document.querySelector("#mini-map1 img");
		  let imageUrl = mapImage.getAttribute("src");
		  let regex = /center=(\d+\.\d+),(\d+\.\d+)/;
		  let matches = imageUrl.match(regex);
		let lat = null;
		let lng = null;
		 if (matches && matches.length >= 3) {
		    lat = matches[1];
		    lng = matches[2];
		    console.log(`Latitude: ${lat}`);
		    console.log(`Longitude: ${lng}`);
		} else {
		    console.log("Image URL does not match the expected pattern.");
		}
		  let placeNameElement = document.querySelector("#mini-map1 h4");
		  let placeName = placeNameElement.textContent;
		  let addressElement = document.querySelector("#mini-map1 p");
		  let address = addressElement.textContent;
		  let value = selectedValue;
		create_post(project_id,title2,startdate,deadline,attendance,lat,lng,placeName,address,value);
		$("#projectFeedArea").empty();
		load_board(project_id);
	});
});