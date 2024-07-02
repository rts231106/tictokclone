import * as functions from "firebase-functions";
import * as admin from "firebase-admin";

admin.initializeApp();

//firestore 이벤트를 listen하고 있음 
export const onVideoCreated = functions.firestore
  .document("videos/{videoId}")
  //snapshot은 방금 만들어진 영상을 의미함 

  .onCreate(async (snapshot, context) => {
    //ref을 써야 실제 document로 접근 가능 
    await snapshot.ref.update({ hello: "from functions" });
  });






