'use strict';

module.exports.handler = async (event) => {

  console.log(event)
  
  console.log(process.env.JOBS_TABLE)

  return {
    statusCode: 200,
    body: JSON.stringify({ msg: "Tudo ok!" })
  }

}
 
