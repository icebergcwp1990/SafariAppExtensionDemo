document.addEventListener("DOMContentLoaded", function(event) {
                          
                          console.log("DOM content is loaded..");
                          
                          safari.extension.dispatchMessage("DOMContentLoaded");
  
});

//The message is packaged as an event whose type is "message"
safari.self.addEventListener("message", function(event) {
                          
                             if (event.name == "MessageFromSafariAppExtension") {
                                alert("Hi, This is a message received from safari app extension.")
                             }else {
                                console.log("Received a message named: "+ event.name);
                             }
                          
                          });
