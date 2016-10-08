module ExternalIP
export externalIP

const sh = @static if is_windows()
    `nslookup myip.opendns.com. resolver1.opendns.com`
else
    `dig +short myip.opendns.com @resolver1.opendns.com`
end

function externalIP()
    stdout = STDOUT
    redirect_stdout()
    p = Pipe()
    run(pipeline(sh, stdout=p))
    redirect_stdout(stdout)
    parseoutput(p)
end

@static if is_windows()
    function parseoutput(p)
        String(readline(p))
        String(readline(p))
        String(readline(p))
        String(readline(p))
        m = match(r"[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+", String(readline(p)))
        ifelse(m===nothing,"",m.match)
    end
else
    function parseoutput(p)
        strip(String(readline(p)))
    end
end

end
