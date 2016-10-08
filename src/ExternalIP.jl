module ExternalIP

const sh = @static if is_windows()
    `nslookup myip.opendns.com. resolver1.opendns.com`
else
    `dig +short myip.opendns.com @resolver1.opendns.com`
end

function externalIP()
    stdout = STDOUT

    p = Pipe()
    run(pipeline(sh, stdout=p))
    parseoutput(p)
end

@static if is_windows()
    function parseoutput(p)
        String(readline(p))
    end
else
    function parseoutput(p)
        strip(String(readline(p)))
    end
end

end
