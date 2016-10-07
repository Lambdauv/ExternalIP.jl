module ExternalIP

const sh = @static if is_windows()
    `nslookup myip.opendns.com. resolver1.opendns.com`
else
    `dig +short myip.opendns.com @resolver1.opendns.com`
end

function externalIP()
    stdout = STDOUT

    r,w = redirect_stdout()
    run(sh)
    redirect_stdout(stdout)
    parseoutput(r)
end

@static if is_windows()
    function parseoutput(r)
        String(readavailable(r))
    end
else
    function parseoutput(r)
        strip(String(readavailable(r)))
    end
end

end
