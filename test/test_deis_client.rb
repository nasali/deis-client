require 'minitest/autorun'
require 'deis_client'

class DeisClientTest < Minitest::Test
  def self.test_order
    :alpha
  end

  def setup
    @username = ENV['DEIS_USER'] || 'humpty'
    @password = ENV['DEIS_PASSWORD'] || 'dumpty'
    @mock = true
    @client = DeisClient.new(ENV['DEIS_CONTROLLER'] || "http://controller.example.com",
                            @username,
                            @password,
                            @mock
                           )
    @key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDZ47ISBG2bIQYV62g5qC58tRvHKh+OMITuxT/YyZzIZYmpDncmDLvaBVX7e3/V5d4CdJui/0pHGW/lnUtUUnTwexO1RABPENiCmUQAD7+QZbKyrYE43GHcXcZjEnAJIDt0FmRjGPFr99x/1kuKCAsouly6uTeRgt3DIjJWCkfvo5PBsdezgChcMCj3EDBqlR83qNFnL+at2I73Fv7GdNV/n7ORSru9POUGAqjdAv2jw02eZYKrxCZPRGimYRe+o0G7aMc6GDjWmonSL08yLryKIjrBD7C+YAzO8Z9UTF2EjgHQ2pKGQuPB5YS8X5APGQAy7HVWlMgBK6jcDuKz9ITLcKkkLUpX4ILch3ppR9OahxYCyJsTegHE3Vwtd0lP53eP/XsPOtMmd+gMch+N/HcK8N9U3c/3+LQpof1KG/SzFvOcplj7G29FDuMI9ziFkOxj7HBjJb4q3LYvOHAfFJIdmLcEH5ckyodxVRCKkravMJRT9X9S8G2MkX+J9/qH/3HNedgvWuqvtCdaozWnjTTU2yoLKUdoMKt1FHRLNLJKFdi27+sapTfP0Cs4IR8LY9sZw1LRk7YzCz21nb5jQs6X/npt2Szv7z0WZ/QUl81jQN6iVY4A5XZDy5cx9mXkxuBYSMl1PMLOR2k30bk6hnTmurhHFAgcDdmOQ3qhq9eUmQ== user@example.com"
  end


  def test_app_create
      response = @client.app_create("fluffy")
      assert response["id"] == "fluffy" || @mock
      assert response["owner"] == @username || @mock
      assert response["uuid"] || @mock
  end

  def test_key_add
      assert_raises(DeisError) {
        @client.key_add(nil, nil)
      }
      response = @client.key_add(@username, @key)
      assert response["id"] == @username || @mock
      assert response["owner"] == @username || @mock
      assert response["public"] == @key || @mock
  end

end
