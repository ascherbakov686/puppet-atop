require 'spec_helper_acceptance'
 
describe 'atop' do
  let(:manifest) {
    <<-EOS    
include atop
EOS
  }
  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end
 
  it 'should apply a second time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end
end

describe 'atop_customise' do
  let(:manifest) {
    <<-EOS
class { 'atop':
  service_run    => true,
  service_enable => false,
  interval       => 120,
  logpath        => '/var/log/myatop/atop',
  confpath       => '/etc/sysconfig/atop',
}
EOS
  }
  it 'should apply without errors' do
    apply_manifest(manifest, :catch_failures => true)
  end
 
  it 'should apply a second time without changes' do
    @result = apply_manifest(manifest)
    expect(@result.exit_code).to be_zero
  end
end