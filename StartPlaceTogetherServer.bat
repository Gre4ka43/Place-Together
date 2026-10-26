<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta http-equiv="Cache-Control" content="no-cache, no-store, must-revalidate" />
    <meta http-equiv="Pragma" content="no-cache" />
    <meta http-equiv="Expires" content="0" />
    <title>Cookie check</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600&display=swap" rel="stylesheet">
    <style>
      :root {
        color-scheme: light dark;
      }

      body {
        font-family: 'Inter', Helvetica, Arial, sans-serif;
        background: light-dark(#F8F8F7, #191919);
        color: light-dark(#1f1f1f, #e3e3e3);
        display: flex;
        flex-direction: column;
        align-items: center;
        justify-content: center;
        box-sizing: border-box;
        min-height: 100vh;
        margin: 0;
        padding: 20px;
        text-align: center;
      }

      .container {
        background: light-dark(#FFFFFF, #1F1F1F);
        padding: 32px;
        border-radius: 16px;
        border: 1px solid light-dark(#E2E3E4, #3E3E3E);
        max-width: min(80%, 500px);
        width: 100%;
        color: light-dark(#2B2D31, #D4D4D4);
      }

      h1 {
        font-size: 20px;
        font-weight: 500;
        margin-top: 1rem;
        margin-bottom: 1rem;
        color: light-dark(#2B2D31, #D4D4D4);
      }

      p {
        font-size: 14px;
        color: light-dark(#2B2D31, #D4D4D4);
        line-height: 21px;
        margin: 0 0 1.5rem 0;
      }

      .icon {
        margin-bottom: 1rem;
        line-height: 0;
      }

      .button-container {
        display: flex;
        justify-content: flex-end;
        gap: 10px;
        margin-top: 2rem;
      }

      button {
        background-color: light-dark(#fff, #323232);
        color: light-dark(#2B2D31, #FCFCFC);
        border: 1px solid light-dark(#E2E3E4, #3E3E3E);
        border-radius: 12px;
        padding: 8px 12px;
        font-size: 14px;
        line-height: 21px;
        cursor: pointer;
        transition: background-color 0.2s;
        font-weight: 400;
        font-family: 'Inter', Helvetica, Arial, sans-serif;
        width: 100%;
      }

      button:hover {
        background-color: light-dark(#EAEAEB, #424242);
      }

      .hidden {
        display: none;
      }

      /* Loading Spinner Animation */
      .spinner {
        margin: 0 auto 1.5rem auto;
        width: 40px;
        height: 40px;
        border: 4px solid light-dark(#f0f0f0, #262626);
        border-top: 4px solid light-dark(#076eff, #87a9ff); /* Blue color */
        border-radius: 50%;
        animation: spin 1s linear infinite;
      }

      .logo {
        border-radius: 10px;
        display: block;
        margin: 0 auto 2rem auto;
      }

      .logo.hidden {
        display: none;
      }

      @keyframes spin {
        0% {
          transform: rotate(0deg);
        }
        100% {
          transform: rotate(360deg);
        }
      }
    </style>
  </head>
  <body>
    <div class="container">
      <img
        class="logo"
        src="https://www.gstatic.com/images/branding/productlogos/ai_studio/v1/web-512dp/logo_ai_studio_color_1x_web_512dp.png"
        alt="AI Studio Logo"
        width="256"
        height="256"
      />
      <div class="spinner"></div>
      <div id="error-ui" class="hidden">
        <div class="icon">
          <svg
            version="1.1"
            xmlns="http://www.w3.org/2000/svg"
            viewBox="0 0 24 24"
            width="48px"
            height="48px"
            fill="#D73A49"
          >
            <path
              d="M12,2C6.486,2,2,6.486,2,12s4.486,10,10,10s10-4.486,10-10S17.514,2,12,2z M13,17h-2v-2h2V17z M13,13h-2V7h2V13z"
            />
          </svg>
        </div>
        <div id="stepOne" class="text-container">
          <h1>Action required to load your app</h1>
          <p>
            It looks like your browser is blocking a required security cookie, which is common on
            older versions of iOS and Safari.
          </p>
          <div class="button-container">
            <button id="authInSeparateWindowButton" onclick="redirectToReturnUrl(true)">Authenticate in new window</button>
          </div>
        </div>
        <div id="stepTwo" class="text-container hidden">
          <h1>Action required to load your app</h1>
          <p>
            It looks like your browser is blocking a required security cookie, which is common on
            older versions of iOS and Safari.
          </p>
          <div class="button-container">
            <button id="interactButton" onclick="redirectToReturnUrl(false)">Close and continue</button>
          </div>
        </div>
        <div id="stepThree" class="text-container hidden">
          <h1>Almost there!</h1>
          <p>
            Grant permission for the required security cookie below.
          </p>
          <div class="button-container">
            <button id="grantPermissionButton" onclick="grantStorageAccess()">Grant permission</button>
          </div>
        </div>
      </div>
    </div>
    <script>
      const AUTH_FLOW_TEST_COOKIE_NAME = '__SECURE-aistudio_auth_flow_may_set_cookies';
      const COOKIE_VALUE = 'true';

      function getCookie(name) {
        const cookies = document.cookie.split(';');
        for (let i = 0; i < cookies.length; i++) {
          let cookie = cookies[i].trim();
          if (cookie.startsWith(name + '=')) {
            return cookie.substring(name.length + 1);
          }
        }
        return null;
      }

      function setAuthFlowTestCookie() {
        // Set the cookie's TTL to 1 minute. This is a short lived cookie because it is only used
        // when the user does not have an auth token or their auth token needs to be reset.
        // Making this cookie too long-lived allows the user to get into a state where they can't
        // mint a new auth token.
        document.cookie = `${AUTH_FLOW_TEST_COOKIE_NAME}=${COOKIE_VALUE}; Path=/; Secure; SameSite=None; Domain=${window.location.hostname}; Partitioned; Max-Age=60;`;
      }

      /**
       * Returns true if the test cookie is set, false otherwise.
       */
      function authFlowTestCookieIsSet() {
        return getCookie(AUTH_FLOW_TEST_COOKIE_NAME) === COOKIE_VALUE;
      }

      /**
       * Redirects to the return url. If autoClose is true, then the return url will be opened in a
       * new window, and it will be closed automatically when the page loads.
       * Options:
       *   storageAccessGranted: if true, appends __storage_access_granted=1 to
       *   the return url so the Lua auth script can set the test cookie
       *   server-side (needed for Safari/iOS where document.cookie is blocked).
       */
      async function redirectToReturnUrl(autoClose, storageAccessGranted = false) {
        const initialReturnUrlStr = new URLSearchParams(window.location.search).get('return_url');
        const returnUrl = initialReturnUrlStr ? new URL(initialReturnUrlStr) : null;

        // Prevent potentially malicious URLs from being used
        if (returnUrl.protocol.toLowerCase() === 'javascript:') {
          console.error('Potentially malicious return URL blocked');
          return;
        }

        if (storageAccessGranted) {
          returnUrl.searchParams.set('__storage_access_granted', '1');
        }

        if (autoClose) {
          returnUrl.searchParams.set('__auto_close', '1');
          const url = new URL(window.location.href);
          url.searchParams.set('return_url', returnUrl.toString());
          // Land on the cookie check page first, so the user can interact with it before proceeding
          // to the return url where cookies can be set.
          window.open(url.toString(), '_blank');
          const hasAccess = await document.hasStorageAccess();
          document.querySelector('#stepOne').classList.add('hidden');
          if (!hasAccess) {
            document.querySelector('#stepThree').classList.remove('hidden');
          } else {
            window.location.reload();
          }
        } else {
          window.location.href = returnUrl.toString();
        }
      }

      /**
       * Grants the browser permission to set cookies. If successful, then it redirects to the
       * return url.
       */
      async function grantStorageAccess() {
        try {
          await document.requestStorageAccess();
          // Recent Safari/iOS versions block document.cookie entirely in
          // cross-site iframes, even after requestStorageAccess(). Only
          // server-side Set-Cookie headers work. Signal to the Lua auth script
          // via query param so it can set the test cookie server-side.
          redirectToReturnUrl(false, /* storageAccessGranted= */ true);
        } catch (err) {
          console.log('error after button click: ', err);
        }
      }

      /**
       * Verifies that the browser can set cookies. If it can, then it redirects to the return url.
       * If it can't, then it shows the error UI.
       */
      function verifyCanSetCookies() {
        setAuthFlowTestCookie();
        if (authFlowTestCookieIsSet()) {
          // Check if we are on the auto-close flow, and if so show the interact button.
          const returnUrl = new URLSearchParams(window.location.search).get('return_url');
          const autoClose = new URL(returnUrl).searchParams.has('__auto_close');
          if (autoClose) {
            document.querySelector('#stepOne').classList.add('hidden');
            document.querySelector('#stepTwo').classList.remove('hidden');
          } else {
            redirectToReturnUrl(false);
            return;
          }
        }
        // The cookie could not be set, so initiate the recovery flow.
        document.querySelector('.logo').classList.add('hidden');
        document.querySelector('.spinner').classList.add('hidden');
        document.querySelector('#error-ui').classList.remove('hidden');
      }

      // Start the cookie verification process.
      verifyCanSetCookies();
    </script>
  </body>
</html>
