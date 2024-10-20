# HTTP 통신을 통한 비동기 데이터 처리

- Httpcommunication
  
  1. StatefulWidget으로, 상태 변화가 있는 UI를 구성
  2. 사용자가 데이터를 가져오는 버튼을 클릭할 때마다 UI가 업데이트되고 상태 관리

- _HttpcommunicationState
  
  1. getData() 함수는 외부 API로부터 데이터를 비동기적 받아옴
  2. http.get 메서드를 사용하여 https://jsonplaceholder.typicode.com/posts/1에서 데이터를 요청
  3. 요청 결과는 response.body에 저장하고, setState를 통해 body 변수를 업데이트


