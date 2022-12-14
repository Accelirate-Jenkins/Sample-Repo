%dw 2.0
import * from dw::test::Asserts
fun greeting(time) = 
    if (time < 12 and time > 5) "Good Morning!"
    else if (time >= 12 and time < 17) "Good Afternoon!"
    else "Good Evening!"
---
payload must equalTo(
	{"message": "Hello Anoma! " ++ greeting(now().hour)} 
)