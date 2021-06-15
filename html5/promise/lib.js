//json 을 반환하는 server url 을 호출하는 ajax 함수.
function fnAjaxJson(url,param,successCallback,errorCallback,completeCallback){
	if (url)
	{
		param = param ? param : {};
		jQuery.ajax({
			type:"POST",
			url:url,
			dataType:"JSON", //asp 에서 json 타입으로 반환하므로, 이 값을 설정해 주셔야 합니다.
			data:param,
			success : function(data) {
				//성공시
				if (successCallback)
				{
					successCallback(data);
				}
			},
			complete : function(data) {
				//오류떠도 실행되는 최종 처리 (finally)
				if (completeCallback)
				{
					completeCallback(data);
				}
			},
			error : function(xhr, status, error) {
				//에러발생시
				if (errorCallback)
				{
					errorCallback(xhr, status, error);
				}
			}
		});
	}
}
