import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

//firestore 이벤트를 listen하고 있음 
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  //snapshot은 방금 만들어진 영상을 의미함 
  .onCreate(async (snapshot, context) => {
    //ref을 써야 실제 document로 접근 가능 
    const spawn = require("child-process-promise").spawn;
    //마지막 데이터 베이스에 업로드된 데이터를 전달 
    const video = snapshot.data();
    await spawn("ffmpeg",[
      //input 파일  
      "-i",
      //다운로드 비디오 
      video.fileUrl,
//특정 시간대에 가고 싶음
"-ss",
"00:00:01.000",
"-vframes",
"1",
//사진 화질 낮추기
"-vf",
//가로는 150 세로는 영상비율에 맞춰서 높이를 설정 
"scale= 150:-1",
//어디에 저장할지 정할것
`/tmp/${snapshot.id}.jpg`,
    ]);
    const storage = admin.storage();
    await storage.bucket().upload(  `/tmp/${snapshot.id}.jpg`,{destination:`thumbnails/${snapshot.id}.jpg`,

    });
  });






