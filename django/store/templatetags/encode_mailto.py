# http://djangosnippets.org/snippets/216/
import random
from django import template
from django.template.defaultfilters import stringfilter

"""
    Randomized string encoding
    Inspired by John Gruber's Markdown:
    http://daringfireball.net/projects/markdown/syntax#autolink
"""
register = template.Library()


@register.filter(is_safe=True)
@stringfilter
def encode_string(value):
    """
    Encode a string into it's equivalent html entity.

    The tag will randomly choose to represent the character as a hex digit or
    decimal digit.

    Use {{ obj.name|encode_string }}

    {{ "person"|encode_string }} Becomes something like:
    &#112;&#101;&#x72;&#x73;&#x6f;&#110;
    """
    e_string = ""
    for a in value:
        rtype = random.randint(0, 1)
        if rtype:
            en = "&#x%x;" % ord(a)
        else:
            en = "&#%d;" % ord(a)
        e_string += en
    return e_string


@register.filter(is_safe=True)
def encode_mailto(value, arg):
    """
    Encode an e-mail address and its corresponding link name to its equivalent
    html entities.

    Use {{ obj.email|encode_mailto:obj.name }}

    {{ "j@j.com"|encode_mailto:"j" }} Becomes something like:
    <a href="&#x6d;&#x61;&#x69;&#x6c;&#x74;&#111;&#x3a;&#106;&#x40;&#106;\
    &#46;&#99;&#x6f;&#x6d;">&#x6a;</a>
    """
    address = "mailto:%s" % value
    address = encode_string(address)
    name = encode_string(arg)
    tag = '<a href="%s">%s</a>' % (address, name)
    return tag
