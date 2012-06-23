Given /^I listen to the audio$/ do
  page.execute_script %{
    HTMLAudioElement.prototype.play = function () {
      window.lastPlayedAudio = $(this).attr('src')
    }
  }
end

Then /^I hear "([^"]*)"$/ do |path|
  wait_for(true) do
    audio = page.evaluate_script("window.lastPlayedAudio")
    puts "AUDIO = #{audio}"
    if audio.present?
      audio.end_with? path
    end
  end
end
