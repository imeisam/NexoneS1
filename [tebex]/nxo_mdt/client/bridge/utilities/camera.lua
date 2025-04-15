Camera = {

  -- Function to upload a screenshot to a Discord webhook
  upload = function()
    -- Discord webhook URL
    local webhook = 'https://discord.com/api/webhooks/1250602979040559126/TIFP0jRMWZwtlNPLDv1wqv7u6opMjQK3L8pItKom0H8aiIPvav5JXITPeGd6S8OfovOn'

    -- Request screenshot upload using the 'screenshot-basic' resource
    exports['screenshot-basic']:requestScreenshotUpload(webhook, 'files[]', function(response)
      -- Decode the response JSON
      local resp = json.decode(response)

      -- Extract the photo details from the response
      local photo = {
        id = resp.attachments[1].id,
        size = resp.attachments[1].size,
        width = resp.attachments[1].width,
        height = resp.attachments[1].height,
        date = 0,
        url = resp.attachments[1].proxy_url
      }

      -- Insert the photo into the gallery using the 'drx_mdt:InsertPhotoToGallery' export
      exports.drx_mdt:InsertPhotoToGallery(
        photo.id,
        photo.size,
        photo.width,
        photo.height,
        photo.date,
        photo.url
      )
    end)
  end,
}