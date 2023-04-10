'use strict';
const { Contract} = require('fabric-contract-api');

class testContract extends Contract {



   async queryMarks(ctx,studentId) {
   
    let marksAsBytes = await ctx.stub.getState(studentId); 
    if (!marksAsBytes || marksAsBytes.toString().length <= 0) {
      throw new Error('Id does not exist: ');
       }
      let marks=JSON.parse(marksAsBytes.toString());
      
      return JSON.stringify(marks);
     }

   async addMarks(ctx,studentId,subject1) {
   
    let marks={
       temp:subject1,
       };

    await ctx.stub.putState(studentId,Buffer.from(JSON.stringify(marks))); 
    
    console.log('Added To the ledger Succesfully..');
    
  }

   async deleteMarks(ctx,studentId) {
   

    await ctx.stub.deleteState(studentId); 
    
    console.log('Deleted from the ledger Succesfully..');
    
    }
}

module.exports=testContract;
