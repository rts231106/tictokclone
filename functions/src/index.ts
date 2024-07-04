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
    //서버에서 ffmpeg 소프트웨어의 프로세스를 실행시킴 
    await spawn("ffmpeg",[
      //input 파일  
      "-i",
      //업로드한  비디오 
      video.fileUrl,
//특정 시간대에 가고 싶음
"-ss",
"00:00:01.000",
// 첫번째 frame을 
"-vframes",
"1",
//사진 화질 낮추기
"-vf",
//가로는 150 세로는 영상비율에 맞춰서 높이를 설정 
"scale= 150:-1",
//어디에 저장할지 정할것
`/tmp/${snapshot.id}.jpg`,
    ]);
    //우리가 ffmpeg로 추출한 썸네일 URL을 영상에 넣어주는걸로 
    const storage = admin.storage();
    //admin 을 이용해서 업로드 함 
    const[file,_] =  await storage.bucket().upload(  `/tmp/${snapshot.id}.jpg`,
      {
      destination:`thumbnails/${snapshot.id}.jpg`,

    });
    //공개 파일 만들기 
    await file.makePublic();
    //사용자가 올린 영상을 수정 
    await snapshot.ref.update({thumbnailUrl: file.publicUrl() });

    // admin을 사용해서 
    const db = admin.firestore();

    await db
    //user폴더로 가서 
    .collection("users")
    //비디오를 만든 사용자를 찾는다
    .doc(video.creatorUid)
    //사용자 내에 collection을 만든다 
    .collection("videos")
    //만들어진 영상의 id를 가지고 document를 만들어서 
    .doc(snapshot.id)
    .set({ 
      thumbnailUrl: file.publicUrl(),
      videoId: snapshot.id,
    })
  });






