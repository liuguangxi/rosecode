import base64

def decode_weird_b64(s: str) -> str:
    out = []
    for chunk in s.split():
        b = base64.b64decode(chunk)     # 3 bytes
        out.append(chr(b[0]))
        if b[1] != 0:
            out.append(chr(b[1]))
    return "".join(out)

cipher = "VGgA ZWEA bnMA d2UA cmkA c2IA YXMA ZTYA NAAA"
print(decode_weird_b64(cipher))
print('base64')
