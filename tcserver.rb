require 'formula'

class Tcserver < Formula
  homepage 'http://www.gopivotal.com/?q=pivotal-products/pivotal-application-cloud-fabric/pivotal-tc-server'
  url 'http://public.pivotal.com.s3.amazonaws.com/releases/tcserver/3.0.2.RELEASE/tcserver-3.0.2.RELEASE-developer.tar.gz'
  sha1 'd48c5728d09f043d6d511536f5bb311dca01449e'
  version "3.0.2"
  
  # logs, lib and temp folder need to exist for base template to work
  skip_clean 'libexec/templates/base/logs'
  skip_clean 'libexec/templates/base/lib'
  skip_clean 'libexec/templates/base/temp'
  
  def install
    # Remove Windows scripts
    rm_rf Dir['**/*.bat']

    # Install files
    prefix.install %w{ README.txt licenses/Pivotal_EULA.txt licenses/pivotal-tc-server-developer-open-source-licenses-3.0.2.RELEASE.txt}
    libexec.install Dir['*']
    bin.install_symlink Dir["#{libexec}/*.sh"]
    
    # logs, lib and temp folder need to exist for base template to work
    (libexec/'templates/base/logs').mkpath
    (libexec/'templates/base/lib').mkpath
    (libexec/'templates/base/temp').mkpath
  end

  def caveats; <<-EOS.undent
    By installing, you agree to comply with the license at http://www.pivotal.io/tc-dev-edition-eula. If you disagree with these terms, please uninstall by typing "brew uninstall tcserver" in your terminal window.
 
    Usage:
       To create a new tc Server instance (in current directory):
          tcruntime-instance.sh create myinstance
          
       To create a new tc Server instance with Spring Insight monitoring:
          tcruntime-instance.sh create -t insight myinstance 
       
       To control tc Server instance (in current directory):
          tcruntime-ctl.sh myinstance start
          
    Documentation:
       http://docs.pivotal.io/tcserver

    For inquiries about commercial licensing, support, training, and consulting, please contact us at tcserver@pivotal.io
    EOS
  end
end
