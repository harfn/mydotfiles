import re


PUNCTUATION = {
    "punkt": ".",
    "komma": ",",
    "fragezeichen": "?",
    "ausrufezeichen": "!",
    "doppelpunkt": ":",
    "semikolon": ";",
}


def nerd_dictation_process(text):
    for spoken, symbol in PUNCTUATION.items():
        text = re.sub(
            rf"\s*\b{re.escape(spoken)}\b",
            symbol,
            text,
            flags=re.IGNORECASE,
        )

    # Überflüssige Leerzeichen vor Satzzeichen entfernen.
    text = re.sub(r"\s+([.,!?;:])", r"\1", text)

    # Nach einem Satzzeichen genau ein Leerzeichen setzen.
    text = re.sub(r"([.,!?;:])(?=\S)", r"\1 ", text)

    return text.strip()
