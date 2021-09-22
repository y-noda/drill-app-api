@answer = User.create(
                key: 'users', 
                save_data: {
                  "ABC-23-E00229105": {
                    userid: "ABC-23-E00229105",
                    name: "米田達生",
                    school: "小学校",
                    grade: "3",
                    schoolid: "fg33",
                    class: ["2組", "英語S"],
                    lastLoginDate: "2021-09-09",
                    img: "/img/icon1.png", 
                    crownNum:{ 
                      gold: 10,
                      silver: 12, 
                      bronze: 3 
                    }
                  },
                  "ABC-23-E00229106": {
                    userid: "ABC-23-E00229106",
                    name: "本田佐十郎",
                    school: "小学校",
                    grade: "4",
                    schoolid: "fg33",
                    class: ["3組", "英語A"],
                    lastLoginDate: "2021-09-08",
                    img: "/img/icon2.png", 
                    crownNum:{ 
                      gold: 4,
                      silver: 13, 
                      bronze: 4
                    }
                  }
                }
              )
