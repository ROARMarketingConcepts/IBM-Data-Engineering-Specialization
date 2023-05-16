
// MongoDB Aggregation Exercises

db.marks.find()

{ "_id" : ObjectId("643d2e58ca9650ae1a467e38"), "name" : "Ramesh", "subject" : "maths", "marks" : 87 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e39"), "name" : "Ramesh", "subject" : "english", "marks" : 59 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3a"), "name" : "Ramesh", "subject" : "science", "marks" : 77 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3b"), "name" : "Rav", "subject" : "maths", "marks" : 62 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3c"), "name" : "Rav", "subject" : "english", "marks" : 83 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3d"), "name" : "Rav", "subject" : "science", "marks" : 71 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3e"), "name" : "Alison", "subject" : "maths", "marks" : 84 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e3f"), "name" : "Alison", "subject" : "english", "marks" : 82 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e40"), "name" : "Alison", "subject" : "science", "marks" : 86 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e41"), "name" : "Steve", "subject" : "maths", "marks" : 81 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e42"), "name" : "Steve", "subject" : "english", "marks" : 89 }
{ "_id" : ObjectId("643d2e58ca9650ae1a467e43"), "name" : "Steve", "subject" : "science", "marks" : 77 }
{ "_id" : ObjectId("643d2e59ca9650ae1a467e44"), "name" : "Jan", "subject" : "english", "marks" : 0, "reason" : "absent" }


// 1. Find the total marks for each student across all subjects.

db.marks.aggregate([
    {
        "$group":{"_id":"$name","total":{"$sum":"$marks"}}
    }
])

// output

{ "_id" : "Ramesh", "total" : 223 }
{ "_id" : "Jan", "total" : 0 }
{ "_id" : "Rav", "total" : 216 }
{ "_id" : "Alison", "total" : 252 }
{ "_id" : "Steve", "total" : 247 }

// 2. Find the maximum marks scored in each subject.

db.marks.aggregate([
    {
        "$group":{"_id":"$subject","max":{"$max":"$marks"}}
    }
])

// output

{ "_id" : "english", "max" : 89 }
{ "_id" : "science", "max" : 86 }
{ "_id" : "maths", "max" : 87 }


// 3.  Find the minimum marks scored by each student.


db.marks.aggregate([
    {
        "$group":{"_id":"$name","min":{"$min":"$marks"}}
    }
])

// output

{ "_id" : "Ramesh", "min" : 59 }
{ "_id" : "Jan", "min" : 0 }
{ "_id" : "Rav", "min" : 62 }
{ "_id" : "Alison", "min" : 82 }
{ "_id" : "Steve", "min" : 77 }


// 4.  Find the top two subjects based on average marks.

db.marks.aggregate([
{
    "$group":{
        "_id":"$subject",
        "average":{"$avg":"$marks"}
        }
},
{
    "$sort":{"average":-1}
},
{
    "$limit":2
}
])

// output

{ "_id" : "maths", "average" : 78.5 }
{ "_id" : "science", "average" : 77.75 }


