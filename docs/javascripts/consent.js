var consent = __md_get("__consent")

function setCookie(cname, cvalue, exdays) {
    const d = new Date();
    d.setTime(d.getTime() + (exdays * 24 * 60 * 60 * 1000));
    let expires = "expires="+d.toUTCString();
    document.cookie = cname + "=" + cvalue + ";" + expires + ";path=/";
  }

function getCookie(name) {
    let cookieArr = document.cookie.split(";");

    for(let i = 0; i < cookieArr.length; i++) {
        let pieces = cookieArr[i].split("=");

        if(name === pieces[0].trim()) {
            return decodeURIComponent(pieces[1]);
        }
    }
    return null;
}

if (consent && consent.analytics) {

    if(!getCookie("analytics"))
    {
        const uniqueId = crypto.randomUUID();
        setCookie("analytics", uniqueId)
    }
} else {
    setCookie("analytics", "")
}