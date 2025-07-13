--[[
Pandoc Lua filter to convert \newpage commands to OpenXML page breaks

This filter detects \newpage commands in various forms and converts them
to the appropriate OpenXML page break markup for Word documents.

Usage: pandoc --lua-filter=newpage-to-openxml.lua input.md -o output.docx
]]--

-- Check if we're outputting to a Word document format
local function is_word_output(format)
    return format == "docx" or format == "odt"
end

-- Create OpenXML page break
local function create_openxml_pagebreak()
    return pandoc.RawBlock("openxml", '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')
end

-- Handle RawBlock elements (like ```{=tex}\newpage```)
function RawBlock(elem)
    if not is_word_output(FORMAT) then
        return elem
    end

    -- Check for LaTeX raw blocks containing \newpage
    if elem.format == "tex" or elem.format == "latex" then
        if string.match(elem.text, "\\newpage") then
            -- Replace \newpage with OpenXML page break
            local cleaned_text = string.gsub(elem.text, "\\newpage%s*", "")

            -- If there's other content besides \newpage, preserve it
            if string.match(cleaned_text, "%S") then
                return {
                    create_openxml_pagebreak(),
                    pandoc.RawBlock(elem.format, cleaned_text)
                }
            else
                -- Only \newpage, just return the page break
                return create_openxml_pagebreak()
            end
        end
    end

    return elem
end

-- Handle Str elements (plain text \newpage)
function Str(elem)
    if not is_word_output(FORMAT) then
        return elem
    end

    -- Check for \newpage in plain text
    if elem.text == "\\newpage" then
        return pandoc.RawInline("openxml", '<w:br w:type="page"/>')
    end

    return elem
end

-- Handle Para elements that might contain \newpage
function Para(elem)
    if not is_word_output(FORMAT) then
        return elem
    end

    local new_content = {}
    local has_pagebreak = false

    for i, inline in ipairs(elem.content) do
        if inline.t == "Str" and inline.text == "\\newpage" then
            -- Replace with page break
            table.insert(new_content, pandoc.RawInline("openxml", '<w:br w:type="page"/>'))
            has_pagebreak = true
        elseif inline.t == "RawInline" and inline.format == "tex" and string.match(inline.text, "\\newpage") then
            -- Handle inline LaTeX \newpage
            table.insert(new_content, pandoc.RawInline("openxml", '<w:br w:type="page"/>'))
            has_pagebreak = true
        else
            table.insert(new_content, inline)
        end
    end

    if has_pagebreak then
        return pandoc.Para(new_content)
    end

    return elem
end

-- Handle RawInline elements
function RawInline(elem)
    if not is_word_output(FORMAT) then
        return elem
    end

    -- Check for LaTeX raw inline containing \newpage
    if (elem.format == "tex" or elem.format == "latex") and string.match(elem.text, "\\newpage") then
        return pandoc.RawInline("openxml", '<w:br w:type="page"/>')
    end

    return elem
end

-- For debugging: uncomment this to see what format Pandoc is using
-- function Meta(meta)
--     print("Output format: " .. FORMAT)
--     return meta
-- end
